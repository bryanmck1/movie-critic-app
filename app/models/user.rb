class User < ApplicationRecord
  enum role: [:user, :admin]
  has_many :reviews 
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
