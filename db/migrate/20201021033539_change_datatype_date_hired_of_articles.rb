class ChangeDatatypeDateHiredOfArticles < ActiveRecord::Migration[6.0]
  def change
    change_column :articles, :date_hired_from, :date
    change_column :articles, :date_hired_to, :date
  end
end
