class AddUniqueIndexToExchangeEvents < ActiveRecord::Migration[7.0]
  def change
    add_index :exchange_events, %i[year user_id], unique: true
  end
end
