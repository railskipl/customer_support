class AddAgentIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :agent_id, :integer
  end
end
