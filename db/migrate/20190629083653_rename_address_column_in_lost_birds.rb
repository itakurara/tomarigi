class RenameAddressColumnInLostBirds < ActiveRecord::Migration[5.2]
  def up
    add_column :lost_birds, :lost_address, :string
    add_column :lost_birds, :found_address, :string

    ActiveRecord::Base.connection.execute("UPDATE lost_birds SET lost_address = address WHERE status = 0;")
    ActiveRecord::Base.connection.execute("UPDATE lost_birds SET found_address = address WHERE status = 1;")

    remove_column :lost_birds, :address, :string
  end

  def down
    add_column :lost_birds, :address, :string

    ActiveRecord::Base.connection.execute("UPDATE lost_birds SET address = lost_address WHERE status = 0;")
    ActiveRecord::Base.connection.execute("UPDATE lost_birds SET address = found_address WHERE status = 1;")

    remove_column :lost_birds, :lost_address, :string
    remove_column :lost_birds, :found_address, :string
  end
end
