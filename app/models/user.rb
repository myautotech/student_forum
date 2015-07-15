class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable
  belongs_to :customer
  belongs_to :role
  has_and_belongs_to_many :groups
  has_many :posts, through: :groups
  has_many :documents, through: :groups
  has_attached_file :image
  validates_attachment_content_type :image\
  , content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  def self.users
    where(is_deleted: false).order(created_at: :desc)
  end

  def role_name
    try(:role).try(:name)
  end

  def join_date
    created_at.to_date
  end

  def self.customer_users(customer_id)
    where(customer_id: customer_id, is_deleted: false).order(created_at: :desc)
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def super_admin?
    return true if role.name.eql? 'SuperAdmin'
    false
  end

  def admin?
    return true if role.name.eql? 'Admin'
    false
  end

  def group_admin?
    return true if role.name.eql? 'GroupAdmin'
    false
  end

  def member?
    return true if role.name.eql? 'Member'
    false
  end

  def group_member(group)
    return true if groups.find_by(id: group.id)
    false
  end

  def has_pic
    return 'user2-160x160.jpg' if image.blank?
    image
  end

  def customer_logo
    return 'customer.png' unless customer
    return 'customer.png' if customer.logo.blank?
    customer.logo
  end

  def customer_name
    return 'StudentForum' unless customer
    customer.name
  end

  def live_posts
    posts.where(is_deleted: false).order(created_at: :desc)
  end

  def live_documents
    documents.where(is_deleted: false).order(created_at: :desc)
  end

  def customer_posts
    customer.live_posts
  end

  def customer_documents
    customer.live_documents
  end
end
