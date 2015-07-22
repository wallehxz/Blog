class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :user_id
      t.string :topic_title
      t.string :topic_type
      t.text :topic_content
      t.string :topic_tag

      t.timestamps
    end
  end
end
