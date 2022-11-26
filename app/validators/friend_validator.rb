class FriendValidator < ActiveModel::Validator
  def validate(record)
    Friend.all.each do |request|
      if request.receiver_user_id == record.receiver_user_id && request.requestor_user_id == record.requestor_user_id || request.receiver_user_id == record.requestor_user_id && request.requestor_user_id == record.receiver_user_id

        record.errors.add :base, 'Friend request already sent'
      end
    end
  end
end
