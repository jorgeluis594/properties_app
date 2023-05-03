class Admin::PropertiesController < ApplicationController
  layout "admin"

  expose :property

  def index
  end

  def create
    if property.save
      redirect_to admin_properties_path
    else
      flash[
        :error
      ] = "Error creating property: #{property.errors.full_messages.to_sentence}"
      redirect_to new_admin_property_path
    end
  end

  def show
    @property = Property.find(params[:id])
  end

  private

  def property_params
    params.require(:property).permit(
      :property_type,
      :price_cents,
      :area,
      :bedrooms,
      :bathrooms,
      :region,
      :locality,
      images: []
    )
  end
end
