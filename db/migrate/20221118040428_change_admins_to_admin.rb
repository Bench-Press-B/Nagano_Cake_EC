class ChangeAdminsToAdmin < ActiveRecord::Migration[6.1]
  def change
    rename_table :admins, :admin
  end
end
