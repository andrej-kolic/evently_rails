class Api::V1::UserSerializer < Api::V1::BaseSerializer
  attributes :id, :username#, :notes,  :admin, :created_at, :updated_at

  #has_many :microposts

end
