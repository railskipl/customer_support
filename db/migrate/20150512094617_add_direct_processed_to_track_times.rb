class AddDirectProcessedToTrackTimes < ActiveRecord::Migration
  def change
    add_column :track_times, :direct_processed, :boolean, :default => false
    add_column :track_times, :direct_user_id, :integer
  end
end
