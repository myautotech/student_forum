class Document < ActiveRecord::Base
  belongs_to :category
  has_many :file_data
end
