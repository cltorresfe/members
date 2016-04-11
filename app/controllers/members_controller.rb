class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  require 'pry'
  # GET /members
  # GET /members.json
  def index
    if params[:name].present?
      @members = Member.search(params[:name]).paginate(page: params[:page], per_page: 10)
        respond_to do |format|
        format.html # index.html.erb
      end
    else
      @members = Member.paginate(page: params[:page], per_page: 10)
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  def search
    @members = Member.search(params[:search_member])
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        WelcomeMember.notify(@member).deliver_later!
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:name, :adress, :email, :phone, :status_id, :church_id, responsibility_ids:[])
    end

end
