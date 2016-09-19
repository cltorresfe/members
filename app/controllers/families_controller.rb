class FamiliesController < ApplicationController
  before_action :set_family, only: [:edit, :update, :destroy]

  # GET /families
  # GET /families.json
  def index
    @families = current_church.families
    flash.now[:alert] = t('.not_found') if @families.blank?
  end

  # GET /families/new
  def new
    @family = Family.new
  end

  # GET /families/1/edit
  def edit
  end

  # POST /families
  # POST /families.json
  def create
    @family = Family.new(family_params)
    @family.church = current_church

    if @family.save
      flash[:notice] = t('.success', name: @family.name)
      redirect_to action: :index
    else
      render :new
    end
  end

  # PATCH/PUT /families/1
  # PATCH/PUT /families/1.json
  def update
    @family.church = current_church
    if @family.update(family_params)
      flash[:notice] = t('.success', name: @family.name)
      redirect_to action: :index
    else
      render :edit
    end
  end

  # DELETE /families/1
  # DELETE /families/1.json
  def destroy
    @family.destroy
    redirect_to families_url, notice: 'Family was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_family
    @family = Family.find(params[:id])
  end

  def family_params
    params.require(:family).permit(:name, :married_at, :address, :phone, :city,
                                   :country)
  end
end
