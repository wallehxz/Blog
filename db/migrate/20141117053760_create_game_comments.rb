class CreateGameComments < ActiveRecord::Migration
  def change
    create_table :game_comments do |t|
      t.integer :game_id
      t.integer :user_id
      t.text :comment

      t.timestamps
    end
  end
end
