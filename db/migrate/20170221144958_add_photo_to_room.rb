class AddPhotoToRoom < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :photo, :string
    add_column :rooms, :url, :string
  end
end
