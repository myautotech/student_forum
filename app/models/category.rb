class Category < ActiveRecord::Base
  belongs_to :group
  has_many :posts
  has_many :documents

  def live_posts
    posts.where(is_deleted: false).order(created_at: :desc)
  end

  def live_documents
    documents.where(is_deleted: false).order(created_at: :desc)
  end
end
