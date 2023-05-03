class ApplicationController < ActionController::Base

  def after_sign_in_path_for(_)
    admin_properties_path
  end

end
