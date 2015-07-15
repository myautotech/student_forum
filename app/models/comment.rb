class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  def user_name
    user.full_name
  end
end
