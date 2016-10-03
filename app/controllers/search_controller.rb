class SearchController < ApplicationController
  def search
    @search_results = current_church.members.active_service.search(params[:search][:q])

  end
end
