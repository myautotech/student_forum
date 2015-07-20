class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      send_notifications
      redirect_to category_post_path(@post.category, @post)\
      , notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize! :delete, @comment
    @comment.update(is_deleted: true)
    redirect_to category_post_path(@post.category, @post)\
    , notice: 'Comment was successfully destroyed.'
  end

  def send_notifications
    group = @post.category.group
    group.group_users.each do |u|
      next if current_user.eql? u
      Notification.create(user_id: u.id, comment_id: @comment.id)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end
end
