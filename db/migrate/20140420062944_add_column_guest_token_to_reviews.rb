class AddColumnGuestTokenToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :guest_token, :string
  end
end
