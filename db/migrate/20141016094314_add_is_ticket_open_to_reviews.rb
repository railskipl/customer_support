class AddIsTicketOpenToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :is_ticket_open, :boolean, default: true
  end
end
