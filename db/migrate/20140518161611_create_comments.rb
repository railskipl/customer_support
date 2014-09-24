class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :review_id
      t.string :title
      t.integer :supplier_id
      t.integer :user_id

      t.timestamps
    end
  end
end
