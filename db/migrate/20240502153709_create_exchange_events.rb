class CreateExchangeEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :exchange_events do |t|
      t.timestamps
    end
  end
end
