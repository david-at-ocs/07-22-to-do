class User < ActiveRecord::Base
  include BCrypt
  
  has_many :tasks
  validates :name, presence: true
  validates :email, presence: true
end