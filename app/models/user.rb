class User < ActiveRecord::Base
  include BCrypt
  
  has_many :tasks
  validates :name, presence: true
  validates :email, presence: true
    
  def encrypt_password(unencrypted_password)
    self.password = BCrypt::Password.create(unencrypted_password)
  end
  
  def correct_password?(attempted_password)
    BCrypt::Password.new(self.password) == attempted_password
  end
  
end