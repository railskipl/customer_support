class CreateNatureOfReviews < ActiveRecord::Migration
  def change
    create_table :nature_of_reviews do |t|
      t.string :title
      t.string :user_id
      t.string :review_type

      t.timestamps
    end
  end
end
