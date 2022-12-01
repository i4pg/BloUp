class FriendshipValidator < ActiveModel::Validator
  def validate(record)
    Friendship.all.each do |request|
      if request.receiver_id == record.receiver_id && request.requester_id == record.requester_id || request.receiver_id == record.requester_id && request.requester_id == record.receiver_id || record.requester_id == record.receiver_id

        record.errors.add :base, 'Friend request already sent'
      end
    end
  end
end
