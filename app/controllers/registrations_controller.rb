class RegistrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    @registration = @event.registrations.build(user: current_user)
    authorize @registration

    if @registration.save
      redirect_to @event, notice: "Successfully registered for event!"
    else
      redirect_to @event, alert: "Unable to register for event."
    end
  end

  def destroy
    @registration = @event.registrations.find_by(user: current_user)
    authorize @registration if @registration

    if @registration&.destroy
      redirect_to @event, notice: "Successfully unregistered from event!"
    else
      redirect_to @event, alert: "Unable to unregister from event."
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
