class AddTicketNumberToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :ticket_number, :string
  end
end
