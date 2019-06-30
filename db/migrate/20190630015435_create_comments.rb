class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.references :lost_bird, foreign_key: true, null: false
      t.timestamps
    end
  end
end
