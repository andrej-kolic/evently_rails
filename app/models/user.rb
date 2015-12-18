class User < ActiveRecord::Base
  has_many :events, dependent: :destroy

  validates :username, presence: true, length: { minimum: 5 }

  def self.authenticate(providedUsername, providedPassword)
    user = find_by_username(providedUsername)
    if user && user.password === providedPassword
      user
    else
      nil
    end
  end


  before_create :generate_authentication_token

  def generate_authentication_token
    loop do
      self.authentication_token = SecureRandom.base64(64)
      break unless User.find_by(authentication_token: authentication_token)
    end
  end


end
