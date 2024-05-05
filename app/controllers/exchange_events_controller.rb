class ExchangeEventsController < ApplicationController
  before_action :set_exchange_event, only: %i[show destroy]

  def index
    @exchange_events = ExchangeEvent.all
  end

  def new
    exchange_event = ExchangeEvent.new
    if exchange_event.save
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
