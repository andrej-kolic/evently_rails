class Api::V1::UsersController < Api::V1::BaseController

  before_filter :authenticate_user!, only: [:show, :update, :destroy]


  def index
    users = User.all
    users = apply_filters(users, params)

    render(
        json: ActiveModel::ArraySerializer.new(
            users,
            each_serializer: Api::V1::UserSerializer,
            root: 'users',
        )
    )
  end


  def show
    user = User.find(params[:id])
    authorize user

    render(json: Api::V1::UserSerializer.new(user).to_json)
    #render(json:user, serializer: Api::V1::UserSerializer)
    #render json:user, serializer: ::UserSerializer
    #render(json:user)
  end

end