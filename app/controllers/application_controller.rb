# frozen_string_literal: true

# application controller
class ApplicationController < ActionController::Base
  before_action :set_query
  before_action :user_permit, if: :devise_controller?

  def set_query
    @query = Item.ransack(params[:q])
  end

  protected
    def user_permit
      devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :display_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :display_name])
    end

end
