class SearchController < ApplicationController
  before_action :beautify_url

  def search
    @search_results = current_church.members.active_service.search(params[:q]).records

  end

  private
  def beautify_url
    if params[:search].present?
      redirect_to search_url(q: params[:search][:q])
    end
  end
end
