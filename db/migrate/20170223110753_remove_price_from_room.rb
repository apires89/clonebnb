class RemovePriceFromRoom < ActiveRecord::Migration[5.0]
  def change
    remove_column :rooms, :price
  end
end
