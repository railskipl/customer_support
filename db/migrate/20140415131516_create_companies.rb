class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :title
      t.integer :user_id
      t.integer :industry_id

      t.timestamps
    end
  end
end
