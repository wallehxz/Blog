class CreateEmbarrassComments < ActiveRecord::Migration
  def change
    create_table :embarrass_comments do |t|
      t.integer :embarrass_id
      t.integer :user_id
      t.text :comment

      t.timestamps
    end
  end
end
