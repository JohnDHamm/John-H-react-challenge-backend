class User < ApplicationRecord
  has_many :appointments

  validates_presence_of :username, :password
end
