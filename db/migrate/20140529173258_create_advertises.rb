class CreateAdvertises < ActiveRecord::Migration
  def change
    create_table :advertises do |t|
      t.string  :image
      t.integer :position
      t.date    :start_date
      t.date    :end_date
			t.string  :link
      t.timestamps
    end
  end
end
