class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
			t.string     :title
			t.references :industry
			t.references :company
			t.date       :date
			t.references :town
			t.time       :datetime
			t.references :location
			t.string     :personal_responsible
			t.string     :nature_of_review
			t.string     :message
			t.string     :account_details
			t.timestamps
    end
  end
end
