class AddColumnTypeToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :review_type, :string
  end
end
