class Event < ActiveRecord::Base
  validates :start_time, presence: true

  belongs_to :user
end
