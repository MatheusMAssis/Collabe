class EventMailer < ApplicationMailer
  def registration_notification
    @event = params[:event]
    @user = params[:user]
    @event_creator = @event.user

    mail(
      to: @event_creator.email,
      subject: "New registration for your event: #{@event.title}"
    )
  end
end
