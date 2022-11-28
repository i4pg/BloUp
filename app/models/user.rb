class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy

  has_many :requested_friends, foreign_key: 'requestor_id', class_name: 'FriendRequest', dependent: :destroy
  has_many :request_received, foreign_key: 'receiver_id', class_name: 'FriendRequest', dependent: :destroy

  has_many :made_requests, foreign_key: 'requestor_user_id', class_name: 'Friend', dependent: :destroy
  has_many :accepted_requests, foreign_key: 'receiver_user_id', class_name: 'Friend', dependent: :destroy

  # we sure to add case insensitivity to your validations on :username
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  # only allow letter, number, underscore and punctuation.
  validates_format_of :username, with: /^[a-zA-Z0-9_.]*$/, multiline: true
  # check if the same email as the username already exists in the database:
  validate :validate_username

  # Create a login virtual attribute in the User model
  # Add login as an User
  attr_writer :login

  def pending_requests(pending = [])
    requested_friends.where(status: 'pending').each { |request| pending << request.receiver_id }
    request_received.where(status: 'pending').each { |request| pending << request.requestor_id }
    pending
  end

  def accepted_requests(accepted = [])
    requested_friends.where(status: 'accepted').each { |request| accepted << request.receiver_id }
    request_received.where(status: 'accepted').each { |request| accepted << request.requestor_id }
    accepted
  end

  def requests(list = [])
    requested_friends.each { |request| list << request.receiver_id }
    request_received.each { |request| list << request.requestor_id }
    list
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
