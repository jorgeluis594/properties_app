require_relative "../services/properties_searcher"

class PropertiesController < ApplicationController
  attr_reader :properties

  before_action :set_properties, only: [:index]

  private

  def set_properties
    @properties = PropertiesSearcher.call(search_params)
  end

  def search_params
    params.permit(:operation, :min_price, :max_price, :locality)
  end
end
