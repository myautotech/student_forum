class Post < ActiveRecord::Base
  belongs_to :category
  has_many :comments
  has_many :file_data

  def live_comments
    comments.where(is_deleted: false).order(created_at: :desc)
  end

  def self.posts
    where(is_deleted: false).order(created_at: :desc)
  end
end
