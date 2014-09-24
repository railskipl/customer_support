class AlterColumnMessageToReviews < ActiveRecord::Migration
  def change
		change_column :reviews, :message ,:text
		change_column :reviews, :modified_review ,:text
  end
end
