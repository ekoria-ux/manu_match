class AddAdminToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :administrator, :boolean, null: false, default: false
  end
end
