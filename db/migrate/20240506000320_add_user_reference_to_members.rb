class AddUserReferenceToMembers < ActiveRecord::Migration[7.0]
  def change
    add_reference :members, :user, null: false, foreign_key: true
  end
end
