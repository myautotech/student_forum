class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def show
    @post = @category.posts.build
    @document = @category.documents.build
    authorize! :read, @category
  end

  def new
    @group = Group.find(params[:group_id])
    @category = @group.categories.build
    authorize! :create, @category
  end

  def edit
    authorize! :update, @category
  end

  def create
    @group = Group.find(params[:group_id])
    @category = @group.categories.new(category_params)
    if @category.save
      redirect_to group_path(@group), notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to group_path(@group), notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize! :delete, @category
    @category.update(is_deleted: true)
    redirect_to group_path(@group), notice: 'Category was successfully destroyed.'
  end

  private

  def set_category
    @group = Group.find(params[:group_id])
    @category = @group.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description, :group_id)
  end
end
