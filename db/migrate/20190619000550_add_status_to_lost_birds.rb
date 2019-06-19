class AddStatusToLostBirds < ActiveRecord::Migration[5.2]
  def change
    add_column :lost_birds, :status, :integer
  end
end
