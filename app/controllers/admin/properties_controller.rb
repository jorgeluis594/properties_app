class Admin::PropertiesController < ApplicationController
  layout "admin"

  def index
    @properties = Property.all
  end

  def show
    @property = Property.find(params[:id])
  end
end
