class MinistriesController < ApplicationController
  before_action :set_ministry, only: [:edit, :update, :destroy]

  # GET /ministries
  # GET /ministries.json
  def index
    @ministries = current_user.church.ministries.paginate(page: params[:page], per_page: 18)
    if(@ministries.blank?)
      flash[:alert] = I18n.t('flash_messages.ministries_no_found')
    end
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
    @ministry.church = current_user.church
    respond_to do |format|
      if @ministry.save
        flash[:notice] = 'Ministry was successfully created.'
        format.html { redirect_to action: :index}
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /ministries/1
  # PATCH/PUT /ministries/1.json
  def update
    respond_to do |format|
      if @ministry.update(ministry_params)
        flash[:notice] = 'Ministry was successfully created.'
        format.html { redirect_to action: :index}
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /ministries/1
  # DELETE /ministries/1.json
  def destroy
    @ministry.destroy
    respond_to do |format|
      format.html { redirect_to ministries_url, notice: 'Ministry was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ministry
      @ministry = Ministry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ministry_params
      params.require(:ministry).permit(:name, :description, responsibility_ids: [])
    end
end
