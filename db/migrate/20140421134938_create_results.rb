class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :poll_id
      t.integer :option_id

      t.timestamps
    end
  end
end
