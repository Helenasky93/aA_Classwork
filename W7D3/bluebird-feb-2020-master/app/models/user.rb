# == Schema Information
#
# Table name: users
#
#  id                    :bigint           not null, primary key
#  username              :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  email                 :string           not null
#  age                   :integer          not null
#  political_affiliation :string
#

class User < ApplicationRecord
  # attributes that are columns automatically get getters/setters
  
  # Validations are run when you save (.save)
  validates :username, :email, :session_token, presence: true, uniqueness: true 
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true } # plain text password must be atleast 6 characters
  # validate :custom_validation_method
  
  # Validations call getter methods of things that are being validated
  # need getter for password in order for the validation to work
  attr_reader :password 

  # calls ensure_session_token right before validations are run (before saving to db)
  before_validation :ensure_session_token
  # after_initialize :ensure_session_token

  has_many :chirps,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Chirp

  has_many :likes,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Like

  has_many :liked_chirps,
    through: :likes,
    source: :chirp 

  has_many :comments,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Comment

  def self.find_by_credentials(username, password)
    # Check that the user exists in db
    user = User.find_by(username: username)

    # don't need to check password if there is no user in db
    return nil unless user

    # assume user is in db
    # verify that the supplied password matches what we have on file for user
    user.is_password?(password) ? user : nil # our #is_password? method
  end
  
  def is_password?(password)
    # take stringified pw_digest and turn in an PW object
    # password_object = BCrypt::Password.new(self.password_digest) 
    # use BCrypt's is_password? to check equality
    # password_object.is_password?(password)

    # one liner version
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    # need to create instance variable for getter method/validations
    @password = password # plain text

    # Turn plain text password into digest and set as user's password_digest
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    # generates session token for user if it's not already set
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    # change session token
    self.session_token = SecureRandom.urlsafe_base64

    # save to the db, loudly
    self.save!

    # return session_token
    self.session_token
  end
end
