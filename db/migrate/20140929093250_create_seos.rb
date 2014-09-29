class CreateSeos < ActiveRecord::Migration
  def change
    create_table :seos do |t|
      t.string :meta_title
      t.text :meta_description
      t.text :meta_keyword

      t.timestamps
    end
  end
end
