class DownloadLog < ActiveRecord::Base
  belongs_to :file_datum
  belongs_to :user
end
