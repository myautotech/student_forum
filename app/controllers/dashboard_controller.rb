class DashboardController < ApplicationController
  def index
    redirect_to groups_path \
    unless current_user.super_admin? || current_user.admin?
  end
end
