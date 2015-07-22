class CreateGameLives < ActiveRecord::Migration
  def change
    create_table :game_lives do |t|
      t.string :live_title
      t.string :live_url
      t.string :live_type
      t.string :live_interval
      t.string :person_name
      t.string :person_cover
      t.text :person_resume
      t.integer :attention, :default=> 1

      t.timestamps
    end
  end
end
