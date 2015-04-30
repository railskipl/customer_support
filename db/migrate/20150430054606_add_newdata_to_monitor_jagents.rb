class AddNewdataToMonitorJagents < ActiveRecord::Migration
  def change
    add_column :monitor_jagents, :assign_modified, :boolean
    add_column :monitor_jagents, :assignee_modified, :boolean
  end
end
