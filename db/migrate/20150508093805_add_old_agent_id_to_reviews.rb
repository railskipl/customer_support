class AddOldAgentIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :old_agent_id, :integer
  end
end
