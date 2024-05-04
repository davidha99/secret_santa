class ExchangeEventController < ApplicationController
  before_action :set_exchange_event, only: %i[show destroy]

  def index
    @exchange_events = ExchangeEvent.all
  end

  def show
  end

  def create
    exchange_event = ExchangeEvent.new
    if exchange_event.save
      exchange_event.run
    else
      reditect_to families_path, notice: 'Could not create exchange event.'
    end
  end

  def destroy
    @exchange_event.destroy

    redirecto_to exchange_events_path, notice: 'Exchange event was successfully destroyed.'
  end

  private

  def set_exchange_event
    @exchange_event = ExchangeEvent.find(params[:id])
  end

  def exchange_event_params
    params.require(:exchange_event).require(:id)
  end
end
