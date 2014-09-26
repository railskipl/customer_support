class AddNotesToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :notes, :text
  end
end
