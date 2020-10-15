class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.datetime :date_hired_from, null: false
      t.datetime :date_hired_to, null: false
      t.boolean :user_only, null: false, default: false
      t.string :area
      t.string :category
      t.text :remark
      t.text :skill

      t.timestamps
    end
  end
end
