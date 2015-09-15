class User < ActiveRecord::Base
  attr_accessor :remember_token
  has_many :posts
  
  before_save {self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true #allowing nil for user update, has seperate validation upon original creation
  
  
  #returns hash digest of given string
  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  
  private
  
    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
  
end