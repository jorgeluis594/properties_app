require_relative "../services/properties_searcher"

class PropertiesController < ApplicationController
  expose :property

  before_action :set_properties, only: [:index]

  private

  FIRST_PAGE = 1.freeze

  def set_properties
    @properties = PropertiesSearcher.call(search_params).paginate(page: params[:page] || FIRST_PAGE)
  end

  def search_params
    params.permit(property_search: [:operation, :min_price, :max_price, :locality])
  end
end
