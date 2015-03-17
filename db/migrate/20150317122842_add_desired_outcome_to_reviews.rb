class AddDesiredOutcomeToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :desired_outcome, :string
  end
end
