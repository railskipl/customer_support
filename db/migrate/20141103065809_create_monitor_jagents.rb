class CreateMonitorJagents < ActiveRecord::Migration
  def change
    create_table :monitor_jagents do |t|
      t.integer :review_id
      t.boolean :ticked_closed_by_jagent

      t.timestamps
    end
  end
end
