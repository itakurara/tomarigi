class CreateLostBirds < ActiveRecord::Migration[5.2]
  def change
    create_table :lost_birds do |t|
      t.column :name, :string
      t.references :bird, index: true
      t.references :address, index: true, null: false
      t.column :lost_at, :date
      t.column :found_at, :date
      t.column :ring_number, :string
      t.column :description, :text
      t.timestamps
    end

    add_index :lost_birds, :ring_number
    add_index :lost_birds, :lost_at
    add_index :lost_birds, :found_at
  end
end
