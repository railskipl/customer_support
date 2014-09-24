class AddColumnModifiedReviewToReviews < ActiveRecord::Migration
  def change
		add_column :reviews, :modified_review, :string
		add_column :reviews, :is_modified, :boolean
  end
end
