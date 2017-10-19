class UserTrust < ApplicationRecord
  has_one :from_user, primary_key: :from_user_id, foreign_key: :id, class_name: User
end
