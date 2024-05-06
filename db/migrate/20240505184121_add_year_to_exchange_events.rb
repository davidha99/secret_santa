class AddYearToExchangeEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :exchange_events, :year, :integer, null: false
  end
end
