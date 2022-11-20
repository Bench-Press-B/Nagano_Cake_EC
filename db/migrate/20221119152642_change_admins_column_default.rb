class ChangeAdminsColumnDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :admins, :email, from: "a@a", to: ""
    change_column_default :admins, :encrypted_password, from: "aaaaaa", to: ""
  end
end
