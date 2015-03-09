class AddStatusToMonitorJagents < ActiveRecord::Migration
  def change
    add_column :monitor_jagents, :status, :string
  end
end
