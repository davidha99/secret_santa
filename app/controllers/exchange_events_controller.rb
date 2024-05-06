class ExchangeEventsController < ApplicationController
  before_action :set_exchange_event, only: %i[show destroy]

  def index
    @exchange_events = ExchangeEvent.where(user: current_user)
  end

  def new
    if ExchangeEvent.where(user: current_user, year: Time.zone.now.year).blank?
      exchange_event = ExchangeEvent.new(user: current_user, year: Time.zone.now.year)
      participants = Member.where(user: current_user).includes(:family, :exchanges)
      exchange_event.run(participants)
      redirect_to exchange_events_path, notice: 'Secret Santa event was successfully created.'
    else
      redirect_to exchange_events_path, notice: "You've already created a Secret Santa event for this year."
    end
  end

  def show
  end

  def destroy
    @exchange_event.destroy

    redirect_to exchange_events_path, notice: 'Secret Santa event was successfully destroyed.'
  end

  private

  def set_exchange_event
    @exchange_event = ExchangeEvent.find(params[:id])
  end

  def exchange_event_params
    params.require(:exchange_event).require(:id)
  end
end
