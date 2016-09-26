class TithesController < ApplicationController

  def new
    @tithe = Tithe.new
  end

  def create
    @tithe = Tithe.new(tithe_params)
    @tithe.church = current_church

    if @tithe.save
      flash[:notice] = t('.success')
      redirect_to action: :index
    else
      render :new
    end
  end

  def update

  end

  private


  def tithe_params
    params.require(:tithe).permit(:handed_at, :quantity, :member_id)
  end
end
