class AddChangeDateToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :change_date, :datetime
  end
end
