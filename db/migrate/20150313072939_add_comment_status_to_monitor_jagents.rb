class AddCommentStatusToMonitorJagents < ActiveRecord::Migration
  def change
    add_column :monitor_jagents, :comment_status, :string
  end
end
