class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customer.customers
    authorize! :read, @customers
  end

  def show
    authorize! :read, @customer
  end

  def new
    @customer = Customer.new
    authorize! :create, @customer
  end

  def edit
    role = Role.find_by(name: 'Admin')
    @user = @customer.users.find_by(role_id: role.id)
    authorize! :update, @customer
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      create_customer_admin(user_params)
      redirect_to customers_path, notice: 'Customer was successfully created.'
    else
      render :new
    end
  end

  def create_customer_admin(user_params)
    role = Role.find_by(name: 'Admin')
    user = User.new(user_params)
    user.customer_id = @customer.id
    user.role_id = role.id
    user.save
  end

  def update
    if @customer.update(customer_params)
      update_customer_admin(user_params)
      redirect_to customers_path, notice: 'Customer was successfully updated.'
    else
      render :edit
    end
  end

  def update_customer_admin(user_params)
    role = Role.find_by(name: 'Admin')
    user = @customer.users.find_by(role_id: role.id)
    return create_customer_admin(user_params) unless user
    user.update(user_params)
  end

  def destroy
    authorize! :delete, @customer
    @customer.update(is_deleted: true)
    redirect_to customers_url, notice: 'Customer was successfully destroyed.'
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :street, :city, :state, :country, :pincode, :email, :contact_no, :logo, :is_deleted, :is_disabled)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :contact_no, :password)
  end
end
