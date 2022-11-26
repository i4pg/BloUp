class FriendRequestValidator < ActiveModel::Validator
  def validate(record)
    FriendRequest.all.each do |request|
      if request.receiver_id == record.receiver_id && request.requestor_id == record.requestor_id || request.receiver_id == record.requestor_id && request.requestor_id == record.receiver_id || record.requestor_id == record.receiver_id

        record.errors.add :base, 'Friend request already sent'
      end
    end
  end
end
