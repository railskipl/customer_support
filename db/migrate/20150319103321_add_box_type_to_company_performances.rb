class AddBoxTypeToCompanyPerformances < ActiveRecord::Migration
  def change
    add_column :company_performances, :box_type, :string
  end
end
