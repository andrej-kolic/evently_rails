class User < ActiveRecord::Base
  has_many :events

  validates :username, presence: true, length: { minimum: 5 }
  validates :password, presence: true, length: { minimum: 5 }
end
