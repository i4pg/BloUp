class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy

  # to remove assocation just call delete
  # if you add dependent: :destroy to has_many (no need for belongs_to)
  # this will destroy the user entirely from the db
  # either delete or destroy, delete_all or destroy_all
  belongs_to :friend, class_name: 'User', optional: true
  has_many :friends, class_name: 'User', foreign_key: 'friend_id'

  has_many :sent_requests, foreign_key: 'requester_id', class_name: 'Friendship', dependent: :destroy
  has_many :received_requests, foreign_key: 'receiver_id', class_name: 'Friendship', dependent: :destroy

  # we sure to add case insensitivity to your validations on :username
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  # only allow letter, number, underscore and punctuation.
  validates_format_of :username, with: /^[a-zA-Z0-9_.]*$/, multiline: true
  # check if the same email as the username already exists in the database:
  validate :validate_username

  # Create a login virtual attribute in the User model
  # Add login as an User
  attr_writer :login

  def pendings
    received_requests.pending.or(sent_requests.pending)
  end

  def pending_ids(arr = [])
    pendings.find_each do |pending_request|
      arr << pending_request.requester_id unless pending_request.requester == self
      arr << pending_request.receiver_id unless pending_request.receiver == self
    end
    arr
  end

  def validate_username
    errors.add(:username, :invalid) if User.where(email: username).exists?
  end

  def login
    @login || username || email
  end

  # Because we want to change the behavior of the login action,
  # we have to overwrite the find_for_database_authentication method.
  # The method's stack works like this: find_for_database_authentication
  # calls find_for_authentication which
  # calls find_first_by_auth_conditions.
  # Overriding the find_for_database_authentication method
  # allows you to edit database authentication;
  # overriding find_for_authentication
  # allows you to redefine authentication at a specific point
  # (such as token, LDAP or database).
  # Finally, if you override the find_first_by_auth_conditions method,
  # you can customize finder methods
  # (such as authentication, account unlocking or password recovery).

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value',
                                    { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end
