class ExchangeEventsController < ApplicationController
  before_action :set_exchange_event, only: %i[show destroy]

  def index
    @exchange_events = ExchangeEvent.where(user: current_user).order(year: :desc)
  end

  def new
    year = 2000
    exchange_event = ExchangeEvent.new(user: current_user, year: year)
    participants = Member.where(user: current_user).includes(:family, :exchanges_as_sender)

    if exchange_event.run(participants, year)
      redirect_to exchange_events_path, notice: 'Secret Santa event was successfully created.'
    else
      redirect_to exchange_events_path, notice: exchange_event.errors.full_messages.join(', ')
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
