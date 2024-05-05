class CreateExchanges < ActiveRecord::Migration[7.0]
  def change
    create_table :exchanges do |t|
      t.references :exchange_event, null: false, foreign_key: true
      t.references :sender, null: false, foreign_key: { to_table: :members }
      t.references :recipient, null: false, foreign_key: { to_table: :members }
      t.timestamps
    end
  end
end
