class CreateIndustries < ActiveRecord::Migration
  def change
    create_table :industries do |t|
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end
end
