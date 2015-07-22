class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :account
      t.string :password
      t.string :phone
      t.string :email
      t.string :verify_code
      t.datetime :verify_time
      t.string :signature
      t.string :avatar
      t.string :nickname
      t.date :birthday
      t.string :hobby
      t.string :constellation
      t.string :educational
      t.string :full_name
      t.integer :login_times
      t.string :login_ip
      t.string :qq
      t.string :yy
      t.string :weixin
      t.string :weibo
      t.string :company
      t.string :office
      t.string :inauguration_time
      t.string :colleges
      t.string :discipline
      t.string :school_time
      t.integer :integration
      t.string :project_name1
      t.string :project_url1
      t.string :project_name2
      t.string :project_url2
      t.string :project_name3
      t.string :project_url3
      t.string :project_name4
      t.string :project_url4

      t.timestamps
    end
  end
end
