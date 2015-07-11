class FileDatum < ActiveRecord::Base
  belongs_to :post
  belongs_to :document
  has_attached_file :file
  do_not_validate_attachment_file_type :file
end
