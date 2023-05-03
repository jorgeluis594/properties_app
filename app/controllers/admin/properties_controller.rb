class Admin::PropertiesController < ApplicationController
  layout "admin"

  expose :property

  def index
  end

  def show
    @property = Property.find(params[:id])
  end
end
