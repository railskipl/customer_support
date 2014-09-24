class AddStartDateAndEndDateToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :start_date, :date
    add_column :polls, :end_date, :date
  end
end
