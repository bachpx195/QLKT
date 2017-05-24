class Admin::BaseController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!

  # HÀM TẠO
  def initialize
    super
    current_screen()
  end

  def current_screen
    @current_screen = Admin::ScreenName::Dashboard
  end
end
