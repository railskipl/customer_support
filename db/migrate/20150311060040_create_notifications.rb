class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :comment_id
      t.boolean :is_read, :default => false
      t.references :receiver_agent
      t.references :receiver_jagent
      t.timestamps
    end
  end
end
