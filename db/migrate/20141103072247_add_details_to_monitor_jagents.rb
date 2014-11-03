class AddDetailsToMonitorJagents < ActiveRecord::Migration
  def change
    add_column :monitor_jagents, :archive, :boolean
    add_column :monitor_jagents, :modified_review, :boolean
    add_column :monitor_jagents, :s_comment, :boolean
    add_column :monitor_jagents, :c_comment, :boolean
    add_column :monitor_jagents, :archive_att, :boolean
  end
end
