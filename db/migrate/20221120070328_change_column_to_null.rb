class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :orders, :total_price, true
  end

  def down
    change_column_null :orders, :total_price, false
  end
end
