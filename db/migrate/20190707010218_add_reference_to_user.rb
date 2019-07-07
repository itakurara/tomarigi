class AddReferenceToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :user, foreign_key: true, null: false
    add_reference :lost_birds, :user, foreign_key: true, null: false
  end
end
