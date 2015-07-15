class Document < ActiveRecord::Base
  belongs_to :category
  has_many :file_data

  def self.documents
    where(is_deleted: false).order(created_at: :desc)
  end
end
