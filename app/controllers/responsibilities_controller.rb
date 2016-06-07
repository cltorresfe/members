class ResponsibilitiesController < ApplicationController
  before_action :set_responsibility, only: [:edit, :update, :destroy]

  # GET /responsibilities
  # GET /responsibilities.json
  def index
    @responsibilities = Responsibility.all
    flash[:alert] = I18n.t('flash_messages.charges_no_found') if @responsibilities.blank?
  end

  # GET /responsibilities/new
  def new
    @responsibility = Responsibility.new
  end

  # GET /responsibilities/1/edit
  def edit
  end

  # POST /responsibilities
  # POST /responsibilities.json
  def create
    @responsibility = Responsibility.new(responsibility_params)

    respond_to do |format|
      if @responsibility.save
        format.html { redirect_to action: :index}
        format.json { render :show, status: :created, location: @responsibility }
      else
        format.html { render :new }
        format.json { render json: @responsibility.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /responsibilities/1
  # PATCH/PUT /responsibilities/1.json
  def update
    respond_to do |format|
      if @responsibility.update(responsibility_params)
        format.html { redirect_to action: :index}
        format.json { render :show, status: :ok, location: @responsibility }
      else
        format.html { render :edit }
        format.json { render json: @responsibility.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responsibilities/1
  # DELETE /responsibilities/1.json
  def destroy
    @responsibility.destroy
    respond_to do |format|
      format.html { redirect_to responsibilities_url, notice: 'Responsibility was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_responsibility
      @responsibility = Responsibility.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def responsibility_params
      params.require(:responsibility).permit(:name, :administrative)
    end
end
