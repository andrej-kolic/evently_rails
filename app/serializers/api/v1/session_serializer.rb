class Api::V1::SessionSerializer < Api::V1::BaseSerializer
  #just some basic attributes
  attributes :id, :username, :admin, :token

  def token
    object.authentication_token
  end
end