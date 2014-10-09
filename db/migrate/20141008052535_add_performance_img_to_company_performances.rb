class AddPerformanceImgToCompanyPerformances < ActiveRecord::Migration
  def change
    add_column :company_performances, :performance_img, :string
  end
end
