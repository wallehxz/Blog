class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :account
      t.string :password
      t.string :email
      t.string :phone
      t.string :nickname
      t.string :birthday
      t.string :login_ip
      t.integer :login_count

      t.timestamps
    end
  end
end
