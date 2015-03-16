class AddCommentStatusToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :comment_status, :string
  end
end
