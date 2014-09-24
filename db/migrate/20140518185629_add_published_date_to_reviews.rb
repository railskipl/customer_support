class AddPublishedDateToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :published_date, :datetime
  end
end
