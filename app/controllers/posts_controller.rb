class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.super_admin?
      @posts = Post.posts
    elsif current_user.admin?
      @posts = current_user.customer_posts
    else
      @posts = current_user.live_posts
    end
  end

  def show
    @comment = @post.comments.build
    authorize! :read, @post
  end

  def new
    @category = Category.find(params[:category_id])
    @post = @category.posts.build
    authorize! :create, @post
  end

  def edit
    authorize! :update, @post
  end

  def create
    @category = Category.find(params[:category_id])
    @post = @category.posts.new(post_params)
    if @post.save
      attach_files(params[:files])
      redirect_to group_category_path(@category.group, @category)\
      , notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      attach_files(params[:files])
      redirect_to group_category_path(@category.group, @category)\
      , notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize! :delete, @post
    @post.update(is_deleted: true)
    redirect_to group_category_path(@category.group, @category)\
    , notice: 'Post was successfully destroyed.'
  end

  def attach_files(files)
    return if files.blank?
    files.each { |file| @post.file_data.create(file: file) }
  end

  private

  def set_post
    @category = Category.find(params[:category_id])
    @post = @category.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :category_id)
  end
end
