class Public::EventsController < PublicController

  layout false, except: [:index, :show_event]

  def index
    @events = Event.preload(event_attendees: :user)
              .where('starts_at > ?', Time.now)
              .order(starts_at: :asc)
              .page(params[:page])

    @attendances = current_user.event_ids
  end

  def show
    @event = Event.preload(event_attendees: :user).find(params[:id])
    @attendances = current_user.event_ids
  end

  def book
    @event  = Event.preload(reserves: :user, attendees: :user).find(params[:id])
    @result = @event.add_user(current_user)
  end

  def cancel
    @event  = Event.preload(reserves: :user, attendees: :user).find(params[:id])
    @result = @event.remove_user(current_user)
  end

end