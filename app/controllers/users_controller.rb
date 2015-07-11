class UsersController < ApplicationController
  before_filter :set_user, only: [:edit, :update, :destroy]

  def index
    if current_user.super_admin?
      @users = User.users
    else
      @users = User.customer_users(current_user.customer_id)
    end
    authorize! :read, User
  end

  def new
    @user = User.new
    @customers = Customer.customers
    @customer = Customer.find(params[:customer_id]) if params[:customer_id]
    authorize! :create, @user
  end

  def edit
    authorize! :update, @user
  end

  def create
    @customers = Customer.customers
    @user = User.new(user_params)
    @user.customer_id = current_user.customer_id unless current_user.super_admin?
    if @user.save
      assign_role_to_user
      redirect_to users_path, notice: 'User created successfully'
    else
      render :new
    end
  end

  def assign_role_to_user
    role = Role.find_by(name: 'Member')
    @user.update(role_id: role.id)
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User updated successfully'
    else
      render :edit
    end
  end

  def destroy
    authorize! :delete, @user
    @user.update(is_deleted: true)
    redirect_to users_url, notice: 'User deleted successfully'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name\
    , :email, :customer_id, :password, :password_confirmation\
    , :contact_no, :image)
  end
end
