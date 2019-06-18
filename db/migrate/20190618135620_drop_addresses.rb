class DropAddresses < ActiveRecord::Migration[5.2]
  def change
    drop_table :addresses do |t|
      t.column :zipcode, :string, null: false
      t.column :prefecture, :string, null: false
      t.column :city, :string, null: false
      t.timestamps
    end

    remove_reference :lost_birds, :address, index: true
    add_column :lost_birds, :address, :string
  end
end
