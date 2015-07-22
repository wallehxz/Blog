class CreateEmbarrasses < ActiveRecord::Migration
  def change
    create_table :embarrasses do |t|
      t.integer :user_id
      t.text :process
      t.string :picture
      t.integer :chan_count, :default=> 1

      t.timestamps
    end
  end
end
