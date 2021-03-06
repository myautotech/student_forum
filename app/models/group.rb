class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :customer
  has_many :categories
  has_many :posts, through: :categories
  has_many :documents, through: :categories
  has_attached_file :image
  validates :name, uniqueness: true
  validates_attachment_content_type :image\
  , content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  def self.groups
    where(is_deleted: false).order(created_at: :desc)
  end

  def self.customer_groups(customer_id)
    where(customer_id: customer_id, is_deleted: false).order(created_at: :desc)
  end

  def group_users
    users.where(is_deleted: false).order(created_at: :asc)
  end

  def live_categories
    categories.where(is_deleted: false).order(created_at: :desc)
  end

  def group_admin
    role = Role.find_by(name: 'GroupAdmin')
    users.find_by(role_id: role.id)
  end

  def has_pic
    return 'photo1.png' if image.blank?
    image
  end
end
