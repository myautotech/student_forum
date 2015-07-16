class DashboardController < ApplicationController
  def index
    if current_user.super_admin?
      redirect_to customers_path
    elsif current_user.admin?
      redirect_to users_path
    else
      redirect_to groups_path
    end
  end
end
