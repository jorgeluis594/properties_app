class Admin::PropertiesController < ApplicationController
  layout "admin"

  expose :property
  expose :properties, -> { Property.all }

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

  def destroy
    if property.destroy
      flash[:success] = "Property deleted"
    else
      flash[
        :error
      ] = "Error deleting property: #{property.errors.full_messages.to_sentence}"
    end

    redirect_to admin_properties_path
  end

  private

  def property_params
    params.require(:property).permit(
      :id,
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
