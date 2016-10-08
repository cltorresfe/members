class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :load_ministries, only: [:new, :edit]

  # GET /members
  # GET /members.json
  def show
    @ministries = @member.ministries
    @tithe = Tithe.new
    @tithes = @member.tithes_by_date(1.year.ago.beginning_of_day, Time.now).sorted
    @responsibilities = @member.responsibilities
    @attendances = @member.attendances.sorted
                          .paginate(page: params[:page], per_page: 12)
    @families = current_church.families
    gon.tithes_year = @tithes if @tithes.present?
    if @member.family
      @family = @member.family
      @members_family = @family.members
    end
  end

  def index
    if current_church.present? && current_church.members.present?
      @members = current_church.members.sorted
    else
      flash.now[:notice] = t('.not_found')
      return
    end
    @members = @members.paginate(page: params[:page], per_page: 24)
  end

  # GET /members/new
  def new
    @member = Member.new(status: :active)
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)
    @member.church = current_church
    if @member.save
      flash[:notice] = t('.success')
      redirect_to action: :index
    else
      load_ministries
      render :new
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    if @member.update(member_params)
      flash[:notice] = t('.success')
      redirect_to action: :index
    else
      load_ministries
      render :edit
    end
  end

  def associated_family
    @family = current_church.families
                            .where(id: params[:member][:family_id]).first
    @member = current_church.members.where(id: params[:id]).first

    if @member
      @member.family = @family
      @member_head = @member.head_family.first if @family
      if params[:member][:role] != 'head_family' || @member_head.nil?
        if @member.update(member_params)
          flash[:notice] = t('.success')
          redirect_to action: :show
        end
      else
        flash[:alert] = t('.error_head_family', member: @member_head.full_name)
        redirect_to action: :show
      end
    end
  end

  def add_tithes
    @member = current_church.members.where(id: params[:id]).first
    @tithe = Tithe.new
    @tithe.handed_at = params[:tithe][:handed_at]
    @tithe.quantity = params[:tithe][:quantity]
    @tithe.member = @member
    @tithe.church = current_church

    if @tithe.save
      MemberMailer.send_notification_tithe(
        params[:id], @tithe.id, current_user.id
      ).deliver_later
      flash[:notice] = t('.success')
    else
      flash[:alert] = t('.error_save')
    end
    redirect_to action: :show
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    redirect_to members_url, notice: t('.success')
  end

  def send_mail
    if params[:subject].present?
      @member = Member.find(params[:id])
      if current_church.members.include?(@member)
        MemberMailer.send_message(params[:subject], params[:body], @member.id,
                                  current_user.id).deliver_later
        flash.now[:notice] = t('.success')
      else
        render status: :forbidden
      end
    else
      flash.now[:alert] = t('.error')
      render status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(
      :first_name, :last_name, :gender, :run, :city, :country, :birth_date,
      :testimony, :baptism_date, :membership_date, :discipline_date,
      :transfer_date, :facebook, :twitter, :skype, :address, :email, :phone,
      :status, :role, :avatar, charge_ids: []
    )
  end

  def load_ministries
    @ministries = Ministry.by_church(current_church)
  end
end
