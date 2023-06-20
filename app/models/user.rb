class User < ApplicationRecord
  enum role: [:user, :admin]
  has_many :reviews 
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable 
end