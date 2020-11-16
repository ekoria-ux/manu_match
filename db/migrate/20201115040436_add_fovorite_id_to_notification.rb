class AddFovoriteIdToNotification < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :favorite_id, :integer
  end
end
