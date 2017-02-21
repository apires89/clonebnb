class AddActivateToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :activate, :boolean
  end
end
