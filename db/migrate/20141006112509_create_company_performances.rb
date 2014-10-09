class CreateCompanyPerformances < ActiveRecord::Migration
  def change
    create_table :company_performances do |t|
      t.text :best_performance
      t.text :worst_performance
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
