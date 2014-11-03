class CreateMaintainences < ActiveRecord::Migration
  def change
    create_table :maintainences do |t|
      t.boolean :status ,:default => false

      t.timestamps
    end
  end
end
