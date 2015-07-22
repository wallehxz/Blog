class CreateRelaxComments < ActiveRecord::Migration
  def change
    create_table :relax_comments do |t|
      t.integer :relax_id
      t.integer :user_id
      t.text :comment

      t.timestamps
    end
  end
end
