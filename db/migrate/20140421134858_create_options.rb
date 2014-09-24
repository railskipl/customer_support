class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :answer
      t.integer :poll_id

      t.timestamps
    end
  end
end
