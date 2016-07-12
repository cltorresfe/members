class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :load_ministries, only: [:new, :edit]

  # GET /members
  # GET /members.json
  def show
    @ministries = @member.ministries
    @responsibilities = @member.responsibilities
    @attendances = @member.attendances.sorted.paginate(page: params[:page], per_page: 12)
  end

  def index
    # search specific of members
    if params[:name].present?
      @members = current_user.search_members(params[:first_name])
      if(@members.size == 1)
        redirect_to edit_member_path(@members.first)
        return
      elsif(@members.blank?)
        flash.now[:notice] = t('.not_found')
      end
    # List all members of the church
    else
      if(current_church.present? && current_church.members.present?)
        @members = current_church.members.sorted
      else
        flash.now[:notice] = t('.not_found')
        return
      end
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
      flash[:notice] = 'Member was successfully created.'
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
      flash[:notice] = 'Member was successfully updated.'
      redirect_to action: :index
    else
      load_ministries
      render :edit
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    redirect_to members_url, notice: t('.success')
  end

  def send_mail
    @member = Member.find(params[:id])
    if MemberMailer.send_message(params[:subject], params[:body], params[:id], current_user.id).deliver_later
      flash.now[:notice] = t('.success')
    else
      flash.now[:alert] = t('.error')
    end
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:first_name, :last_name, :gender, :run, :city,
        :country, :birth_date, :testimony, :baptism_date, :membership_date, :discipline_date,
        :transfer_date, :facebook, :twitter, :skype, :address, :email, :phone, :status, :avatar, charge_ids:[])
    end

    def load_ministries
      @ministries = Ministry.by_church(current_church)
    end

end
