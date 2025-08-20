class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_event, only: [ :show, :edit, :update, :destroy ]

  # GET /events or /events.json
  def index
    @events = Event.includes(:user)

    # Apply user events filter
    if params[:user_events] == "true" && user_signed_in?
      @events = @events.where(user: current_user)
    end

    # Apply search filter
    if params[:search].present?
      @events = @events.search_by_title_and_description(params[:search])
    end

    # Apply category filter
    if params[:category].present? && params[:category] != "all"
      @events = @events.by_category(params[:category])
    end

    # Apply date filter
    if params[:date_filter].present?
      case params[:date_filter]
      when "today"
        @events = @events.where(date: Date.current.beginning_of_day..Date.current.end_of_day)
      when "this_week"
        @events = @events.where(date: Date.current.beginning_of_week..Date.current.end_of_week)
      when "this_month"
        @events = @events.where(date: Date.current.beginning_of_month..Date.current.end_of_month)
      when "upcoming"
        @events = @events.where("date >= ?", Time.current)
      end
    end

    # Default order by date
    @events = @events.order(:date)

    # Apply pagination
    @pagy, @events = pagy(@events, limit: 10)

    authorize @events
  end

  # GET /events/1 or /events/1.json
  def show
    authorize @event
    @comment = Comment.new
    @comments = @event.comments.includes(:user).ordered
  end

  # GET /events/new
  def new
    @event = current_user.events.build
    authorize @event
  end

  # GET /events/1/edit
  def edit
    authorize @event
  end

  # POST /events or /events.json
  def create
    @event = current_user.events.build(event_params)
    authorize @event

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    authorize @event
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    authorize @event
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to events_path, notice: "Event was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.expect(event: [ :title, :description, :date, :category, :cover_image ])
    end
end
