class Adminsdefaultchange < ActiveRecord::Migration[6.1]
  def change
    change_column_default :admins, :email, from: "", to: "a@a"
    change_column_default :admins, :encrypted_password, from: "", to: "aaaaaa"
  end
end
