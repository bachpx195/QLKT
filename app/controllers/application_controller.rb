class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper

  before_action :set_locale
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def after_sign_in_path_for(resource)
    default_sessions()
    set_sessions()
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
