class ChangeColumnToNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :articles, :expired_at, true
  end
end
