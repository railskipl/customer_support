class AddAdminStatusToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :admin_status, :boolean, default: false
  end
end
