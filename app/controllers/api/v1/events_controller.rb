class Api::V1::EventsController < Api::V1::BaseController

  #before_filter :authenticate_user!, only: [:show, :update, :destroy]
  before_action :set_user#, only: [:index, :show, :new, :create, :edit]


  def index
    events = @user.events.all

    render(
        json: ActiveModel::ArraySerializer.new(
            microposts,
            each_serializer: Api::V1::MicropostSerializer,
            root: 'microposts',
            meta: meta_attributes(microposts)
        )
    )
  end



  private

  def set_user
    @user = User.find(params[:user_id])
    @user_id = params[:user_id]
  end


end
