class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy,
                                   :member_ship, :members, :add_members]
  before_action :set_users, only: [:new, :create]

  def index
    if current_user.super_admin?
      @groups = Group.groups
    else
      @groups = Group.customer_groups(current_user.customer_id)
    end
    authorize! :read, Group
  end

  def show
    @category = @group.categories.build
    authorize! :show_read, @group
  end

  def new
    @group = Group.new
    authorize! :create, @group
  end

  def edit
    @users = User.customer_users(@group.customer_id)
    authorize! :update, @group
  end

  def create
    @group = Group.new(group_params)
    @group.customer_id = current_user.customer_id unless current_user.super_admin?
    if @group.save
      assign_group_admin(params[:user])
      redirect_to groups_path, notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  def assign_group_admin(user)
    user = User.find_by(id: user[:id])
    role = Role.find_by(name: 'GroupAdmin')
    user.update(role_id: role.id)
    GroupsUser.create(user_id: user.id, group_id: @group.id)
  end

  def update
    @users = User.customer_users(@group.customer_id)
    if @group.update(group_params)
      update_group_admin(params[:user])
      redirect_to groups_path, notice: 'Group was successfully updated.'
    else
      render :edit
    end
  end

  def update_group_admin(user)
    user = User.find_by(id: user[:id])
    return if @group.group_admin.eql? user
    assign_group_admin(user)
  end

  def destroy
    authorize! :delete, @group
    @group.update(is_deleted: true)
    redirect_to groups_url, notice: 'Group was successfully destroyed.'
  end

  def member_ship
    user = User.find_by(id: params[:user_id])
    if params[:event].eql? 'add'
      GroupsUser.create(user_id: user.id, group_id: @group.id)
    else
      member = GroupsUser.find_by(user_id: user.id, group_id: @group.id)
      member.destroy if member
    end
    redirect_to groups_path, notice: "User #{params[:event]} in group successfully"
  end

  def members
    @users = @group.group_users
    authorize! :update, @group
  end

  def add_members
    if current_user.super_admin?
      @users = User.users
    else
      @users = User.customer_users(current_user.customer_id)
    end
    authorize! :update, @group
  end

  def customers
    @group = Group.new
    @customer = Customer.find(params[:customer_id])
    @users = User.customer_users(@customer.id)
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def set_users
    @customers = Customer.customers
    if current_user.super_admin?
      @users = User.users
    else
      @users = User.customer_users(current_user.customer_id)
    end
  end

  def group_params
    params.require(:group).permit(:name, :status, :customer_id, :image)
  end
end
