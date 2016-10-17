class MinistriesController < ApplicationController
  before_action :set_ministry, only: [:edit, :update, :destroy]
  before_action :set_responsibilities, only: [:new, :create, :edit, :update]

  # GET /ministries
  # GET /ministries.json
  def index
    @ministries = current_church.ministries.sorted
    flash[:alert] = t('.not_found') if @ministries.blank?
  end

  # GET /ministries/new
  def new
    @ministry = Ministry.new
  end

  # GET /ministries/1/edit
  def edit
  end

  # POST /ministries
  # POST /ministries.json
  def create
    @ministry = Ministry.new(ministry_params)
    @ministry.church = current_church

    if @ministry.save
      flash[:notice] = 'Ministry was successfully created.'
      redirect_to action: :index
    else
      render :new
    end
  end

  # PATCH/PUT /ministries/1
  # PATCH/PUT /ministries/1.json
  def update
    @ministry.charges.each do |charge|
      unless params[:ministry][:responsibility_ids].include? charge.responsibility_id.to_s
        charge.charge_members.destroy_all
      end
    end

    if @ministry.update(ministry_params)
      flash[:notice] = 'Ministry was successfully created.'
      redirect_to action: :index
    else
      render :edit
    end
  end

  # DELETE /ministries/1
  # DELETE /ministries/1.json
  def destroy
    @ministry.destroy
    flash[:notice] = t('.success')
  rescue ActiveRecord::InvalidForeignKey
    flash[:alert] = t('.invalid_foreign_key')
  ensure
    redirect_to ministries_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ministry
    @ministry = Ministry.find(params[:id])
  end

  def set_responsibilities
    @responsibilities = current_church.responsibilities
  end

  def ministry_params
    params.require(:ministry).permit(:name, :description, responsibility_ids: [])
  end
end
