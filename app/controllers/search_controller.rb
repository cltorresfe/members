class SearchController < ApplicationController
  before_action :beautify_url, only: [:search]

  def search
    @members = current_church.members.search(params[:q]).records
                             .paginate(page: params[:page], per_page: 12)
    @ministries = current_church.ministries.search(params[:q])
  end

  def autocomplete
    @members = current_church.members.search(params[:term]).records.to_a
    @ministries = current_church.ministries.search(params[:term]).to_a
  end

  private

  def beautify_url
    redirect_to search_url(q: params[:search][:q]) if params[:search].present?
  end
end
