class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.column :zipcode, :string, null: false
      t.column :prefecture, :string, null: false
      t.column :city, :string, null: false
      t.timestamps
    end

    add_index :addresses, :zipcode
    add_index :addresses, :prefecture
    add_index :addresses, :city
  end
end
