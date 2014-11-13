class CreateTrackTimes < ActiveRecord::Migration
  def change
    create_table :track_times do |t|
      t.integer :review_id
      t.date :date_proposed
      t.date :date_complete
      t.integer :user_id

      t.timestamps
    end
  end
end
