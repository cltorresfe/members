class SearchController < ApplicationController
  before_action :beautify_url, only: [:search]

  def search
    @search_results = current_church.members.active_service.search(params[:q]).records

  end

  def autocomplete
    @members = Member.search(params[:term]).records.to_a
  end

  private
  def beautify_url
    if params[:search].present?
      redirect_to search_url(q: params[:search][:q])
    end
  end
end
