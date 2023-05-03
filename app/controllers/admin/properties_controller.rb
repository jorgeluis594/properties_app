require_relative "../../policies/property_policy"

class Admin::PropertiesController < ApplicationController
  include Pundit::Authorization

  layout "admin"

  expose :property
  expose :properties, -> { current_user.properties }

  before_action :authenticate_user!

  def create
    if property.save
      redirect_to admin_properties_path
    else
      flash[:error] = "Error creating property: #{property.errors.full_messages.to_sentence}"
      redirect_to new_admin_property_path
    end
  end

  def show
    authorize property
  end

  def edit
    authorize property
  end

  def update
    authorize property

    if property.update(property_params)
      redirect_to admin_properties_path
    else
      flash[:error] = "Error updating property: #{property.errors.full_messages.to_sentence}"
      redirect_to edit_admin_property_path(property)
    end
  end

  def destroy
    authorize property

    if property.destroy
      flash[:success] = "Property deleted"
    else
      flash[:error] = "Error deleting property: #{property.errors.full_messages.to_sentence}"
    end

    redirect_to admin_properties_path
  end

  private

  def property_params
    params.require(:property).permit(
      :id,
      :user_id,
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
