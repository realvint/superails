class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pagy::Backend
  include ErrorHandling
  def after_sign_in_path_for(resource)
    user_path(resource)
  end
end
