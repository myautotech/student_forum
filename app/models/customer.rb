class Customer < ActiveRecord::Base
  has_many :users
  has_attached_file :logo
  validates_attachment_content_type :logo\
  , content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  def self.customers
    where(is_deleted: false, is_disabled: false).order(created_at: :desc)
  end

  def live_users
    users.where(is_deleted: false).order(created_at: :desc)
  end
end
