class Friend < ApplicationRecord
  validates :request_user_id, uniqueness: { scope: :receiver_user_id }

  belongs_to :requestor_user, class_name: 'User'
  belongs_to :receiver_user, class_name: 'User'
end
