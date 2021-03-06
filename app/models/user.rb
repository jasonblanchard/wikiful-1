class User < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    length:     { maximum: 100 }, 
                    format:     { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :school, :inclusion => {:in => SCHOOLS}
  validates :department, :inclusion => {:in => DEPARTMENTS}
  validates :password, length: { minimum: 6 }  


# Authentication/session methods
  def User.new_remember_token
  	SecureRandom.urlsafe_base64
  end

  def User.digest(token)
  	Digest::SHA1.hexdigest(token.to_s)
  end



# Private methods
  private
	  # Create remember token (cookie) using above method (securerandom.urlsafe_base64)
    def create_remember_token
	  	self.remember_token = User.digest(User.new_remember_token)
	  end

  end
