class AddColumnArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :expired_at, :datetime, null: false

    add_column :articles, :e_count, :integer
  end
end
