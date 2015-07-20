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
    readed_notifications
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
      send_notifications
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

  def send_notifications
    group = @category.group
    group.group_users.each do |u|
      next if current_user.eql? u
      Notification.create(user_id: u.id, post_id: @post.id)
    end
  end

  def readed_notifications
    nf = current_user.unread_ntfs.find_by(post_id: @post.id)
    nf.update(is_readed: true) if nf
    @post.live_comments.each do |cm|
      nf2 = current_user.unread_ntfs.find_by(comment_id: cm.id)
      nf2.update(is_readed: true) if nf2
    end
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
