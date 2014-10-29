class AddJagentIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :jagent_id, :integer
  end
end
