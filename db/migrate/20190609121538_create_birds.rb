class CreateBirds < ActiveRecord::Migration[5.2]
  def change
    create_table :birds do |t|
      t.column :ja_name, :string, null: false
      t.timestamps
    end

    add_index :birds, :ja_name
  end
end
