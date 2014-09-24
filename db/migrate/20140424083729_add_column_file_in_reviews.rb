class AddColumnFileInReviews < ActiveRecord::Migration
  def change
	add_column :reviews, :file, :string
  end
end
