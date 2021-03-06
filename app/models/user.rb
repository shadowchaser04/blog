class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  # ---------------------------------------------------------------------------
  # assosiations
  # ---------------------------------------------------------------------------
  include Imageable
  has_many :articles

  # ---------------------------------------------------------------------------
  # validations
  # ---------------------------------------------------------------------------
  validate :validate_username

  # ---------------------------------------------------------------------------
  # methods
  # ---------------------------------------------------------------------------
  # sign in with email or username
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end


  # validate username, stop emails and username confusion
  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

end
