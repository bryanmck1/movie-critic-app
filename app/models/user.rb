class User < ApplicationRecord
  enum role: [:user, :admin]
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
