class AddIndex < ActiveRecord::Migration
  def change
    add_index :users, :id
    add_index :topics, :user_id
    add_index :notes, :user_id
    add_index :embarrasses, :user_id
    add_index :topic_comments, :topic_id
    add_index :topic_comments, :user_id
    add_index :embarrass_comments, :embarrass_id
    add_index :embarrass_comments, :user_id
    add_index :game_comments, :game_id
    add_index :game_comments, :user_id
    add_index :relax_comments, :user_id
    add_index :relax_comments, :relax_id
  end
end
