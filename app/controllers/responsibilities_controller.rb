class ResponsibilitiesController < ApplicationController
  before_action :set_responsibility, only: [:edit, :update, :destroy]

  # GET /responsibilities
  # GET /responsibilities.json
  def index
    @responsibilities = current_church.responsibilities.sorted
    flash.now[:alert] = t('.not_found') if @responsibilities.blank?
  end

  # GET /responsibilities/new
  def new
    @responsibility = Responsibility.new
    @ministry = Ministry.find(params[:ministry_id])
  end

  # GET /responsibilities/1/edit
  def edit
  end

  # POST /responsibilities
  # POST /responsibilities.json
  def create
    @responsibility = Responsibility.new(responsibility_params)
    @ministry = Ministry.find(params[:responsibility][:ministry_id])
    @charge = Charge.new
    @charge.ministry = @ministry
    @responsibility.church = current_church
    if @responsibility.save
      @charge.responsibility = @responsibility
      @charge.save
      flash.now[:notice] = t('.success')
    end
  end

  # PATCH/PUT /responsibilities/1
  # PATCH/PUT /responsibilities/1.json
  def update
    if @responsibility.update(responsibility_params)
      redirect_to action: :index
    else
      render :edit
    end
  end

  # DELETE /responsibilities/1
  # DELETE /responsibilities/1.json
  def destroy
    @responsibility.destroy
    flash[:notice] = t('.success')
  rescue ActiveRecord::InvalidForeignKey
    flash[:alert] = t('.invalid_foreign_key')
  ensure
    redirect_to responsibilities_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_responsibility
    @responsibility = Responsibility.find(params[:id])
  end

  def responsibility_params
    params.require(:responsibility).permit(:name, :administrative)
  end
end
