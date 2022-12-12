class FriendshipValidator < ActiveModel::Validator
  def validate(record)
    if record.user.friends.include?(record.friend)
      record.errors.add :base,
                        "Both you and #{record.friend.username} are already friends"
    end
  end
end
