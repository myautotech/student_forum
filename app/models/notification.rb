class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  belongs_to :document
  belongs_to :comment

  def post_ntfs?
    return false if post_id.blank?
    true
  end

  def comment_ntfs?
    return false if comment_id.blank?
    true
  end

  def document_ntfs?
    return false if document_id.blank?
    true
  end
end
