class EventsController < ApplicationController

  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:index, :show, :new, :create, :edit]


  # GET /events
  # GET /events.json
  def index
    @events = @user.events.all
  end


  # GET /events/1
  # GET /events/1.json
  def show
  end


  # GET /events/new
  def new
    @event = Event.new
  end


  # GET /events/1/edit
  def edit
  end


  # POST /events
  # POST /events.json
  def create
    @event = @user.events.create(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to action: 'show', id: @event.id, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to action: 'show', id: @event.id, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to user_events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

  def set_user
    @user = User.find(params[:user_id])
    @user_id = params[:user_id]
  end


  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    #params[:event]
    params.require(:event).permit(:title, :description, :location, :start_time)
    #params.permit
  end
end
