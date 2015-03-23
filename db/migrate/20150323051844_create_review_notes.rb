class CreateReviewNotes < ActiveRecord::Migration
  def change
    create_table :review_notes do |t|
      t.string :name
      t.text :note
      t.integer :review_id

      t.timestamps
    end
  end
end
