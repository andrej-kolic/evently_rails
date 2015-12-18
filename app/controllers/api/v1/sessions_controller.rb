class Api::V1::SessionsController < Api::V1::BaseController


  def create
    user = User.authenticate(create_params[:username], create_params[:password])
    if user
      self.current_user = user
      render(
          json: Api::V1::SessionSerializer.new(user, root: false).to_json,
          status: 201
      )
    else
      return api_error(status: 401)
    end
  end


  private

  def create_params
    params.require(:user).permit(:username, :password)
  end
end