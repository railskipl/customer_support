class AddDetailsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :old_jagent_id, :integer
    add_column :reviews, :last_published_agent_id, :integer
  end
end
