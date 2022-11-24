class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles

  # Gmail or me.com Style
  # more info down below
  after_initialize :create_login, if: :new_record?

  # we sure to add case insensitivity to your validations on :username
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validate :validate_username

  # Create a login virtual attribute in the User model
  # Add login as an User
  attr_writer :login

  def login
    @login || username || email
  end

  # check if the same email as the username already exists in the database
  def validate_username
    errors.add(:username, :invalid) if User.where(email: username).exists?
  end

  # Another way to do this is me.com and gmail style.
  # You allow an email or the username of the email.
  # For public facing accounts, this has more security.
  # Rather than allow some hacker to enter a username
  # and then just guess the password,
  # they would have no clue what the user's email is.
  # Just to make it easier on the user for logging in,
  # allow a short form of their email to be used
  # e.g "someone@domain.com" or just "someone" for short.
  def create_login
    return unless username.blank?

    email = self.email.split(/@/)
    login_taken = Pro.where(username: email[0]).first

    self.username = if login_taken
                      self.email
                    else
                      email[0]
                    end
  end
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
#
# def self.find_for_database_authentication(warden_conditions)
#   conditions = warden_conditions.dup

#   # if you want email to be case insensitive
#   conditions[:email].downcase! if conditions[:email]
#   where(conditions.to_h).first

#   if (login = conditions.delete(:login))
#     where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value',
#                                   { value: login.downcase }]).first
#   elsif conditions.has_key?(:username) || conditions.has_key?(:email)
#     where(conditions.to_h).first
#   end
# end

# Allow users to recover their password or confirm their account using their username
# You might want to use the self.find_first_by_auth_conditions(warden_conditions) above
# instead of using this find_for_database_authentication as this one causes problems.
def self.find_first_by_auth_conditions(warden_conditions)
  conditions = warden_conditions.dup

  # if you want email to be case insensitive
  conditions[:email].downcase! if conditions[:email]
  where(conditions.to_h).first

  if (login = conditions.delete(:login))
    where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
  elsif conditions[:username].nil?
    where(conditions).first
  else
    where(username: conditions[:username]).first
  end
end
