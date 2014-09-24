class CreateTowns < ActiveRecord::Migration
  def change
    create_table :towns do |t|
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end
end
