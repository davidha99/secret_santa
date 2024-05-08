class ExchangeEventsController < ApplicationController
  before_action :set_exchange_event, only: %i[show destroy]

  def index
    @exchange_events = ExchangeEvent.where(user: current_user).order(year: :desc)
  end

  def new
    @exchange_event = ExchangeEvent.new
  end

  def create
    @exchange_event = ExchangeEvent.new(exchange_event_params)
    participants = Member.where(user: current_user).includes(:family, :exchanges_as_sender)

    if @exchange_event.run(participants)
      respond_to do |format|
        format.html { redirect_to exchange_events_path, notice: 'Secret Santa event was successfully created.' }
        format.turbo_stream { flash.now[:notice] = 'Secret Santa event was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
      # redirect_to exchange_events_path, notice: exchange_event.errors.full_messages.join(', ')
    end
  end

  def show
  end

  def destroy
    @exchange_events = ExchangeEvent.where(user: current_user)
    @exchange_event.destroy

    respond_to do |format|
      format.html { redirect_to exchange_events_path, notice: 'Secret Santa event was successfully destroyed.' }
      format.turbo_stream { flash.now[:notice] = 'Secret Santa event was successfully destroyed.' }
    end
  end

  private

  def set_exchange_event
    @exchange_event = ExchangeEvent.find(params[:id])
  end

  def exchange_event_params
    params.require(:exchange_event).permit(:year).merge(user: current_user)
  end
end
