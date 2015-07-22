class CreateRelaxMoments < ActiveRecord::Migration
  def change
    create_table :relax_moments do |t|
      t.string :relax_title
      t.date :relax_time
      t.string :relax_audio
      t.text :relax_content
      t.integer :chan_count, :default=> 1

      t.timestamps
    end
  end
end
