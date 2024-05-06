class AddUserReferenceToExchangeEvents < ActiveRecord::Migration[7.0]
  def change
    add_reference :exchange_events, :user, null: false, foreign_key: true
  end
end
