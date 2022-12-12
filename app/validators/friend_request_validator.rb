class FriendRequestValidator < ActiveModel::Validator
  def validate(record)
    FriendRequest.find_each do |request|
      if request.receiver_id == record.receiver_id && request.requester_id == record.requester_id || request.receiver_id == record.requester_id && request.requester_id == record.receiver_id || record.requester_id == record.receiver_id || record.requester.friends.include?(record.receiver) || record.receiver.friends.include?(record.requester)

        record.errors.add :base, 'Friend request already sent'
      end
    end
  end
end
