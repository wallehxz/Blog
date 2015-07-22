class CreateTopicComments < ActiveRecord::Migration
  def change
    create_table :topic_comments do |t|
      t.integer :topic_id
      t.integer :user_id
      t.text :comment

      t.timestamps
    end
  end
end
