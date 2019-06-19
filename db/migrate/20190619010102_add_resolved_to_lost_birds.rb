class AddResolvedToLostBirds < ActiveRecord::Migration[5.2]
  def change
    add_column :lost_birds, :resolved, :boolean, default: false, null: false
  end
end
