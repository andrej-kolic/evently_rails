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


  def create
    user = User.new(create_params)
    return api_error(status: 422, errors: user.errors) unless user.valid?

    user.save!

    render(
        json: Api::V1::UserSerializer.new(user).to_json,
        status: 201,
        location: api_v1_user_path(user.id)
    )
  end


  def update
    user = User.find(params[:id])
    authorize user

    if !user.update_attributes(update_params)
      return api_error(status: 422, errors: user.errors)
    end

    render(
        json: Api::V1::UserSerializer.new(user).to_json,
        status: 200,
        location: api_v1_user_path(user.id),
        serializer: Api::V1::UserSerializer
    )
  end


  def destroy
    user = User.find(params[:id])
    authorize user

    if !user.destroy
      return api_error(status: 500)
    end

    head status: 204
  end




  private


  def create_params
    params.require(:user).permit(
        :username, :password, :admin
    ).delete_if { |k, v| v.nil? }
  end


  def update_params
    create_params
  end

end