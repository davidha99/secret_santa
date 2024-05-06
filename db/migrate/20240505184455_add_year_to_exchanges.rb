class AddYearToExchanges < ActiveRecord::Migration[7.0]
  def change
    add_column :exchanges, :year, :integer, null: false
  end
end
