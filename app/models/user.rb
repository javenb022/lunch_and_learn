class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  has_secure_password

  has_many :api_keys
  has_many :favorites
end