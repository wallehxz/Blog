class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :user_id
      t.string :note_title
      t.date :note_date
      t.string :note_weather
      t.string :note_tag
      t.text :note_content

      t.timestamps
    end
  end
end
