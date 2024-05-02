class AddFamilyRefToMembers < ActiveRecord::Migration[7.0]
  def change
    add_reference :members, :family, null: false, foreign_key: true
  end
end
