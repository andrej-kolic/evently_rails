class Api::V1::EventSerializer < Api::V1::BaseSerializer
  attributes :id, :title, :description, :location, :start_time #, :notes,  :admin, :created_at, :updated_at

  #has_many :microposts

end
