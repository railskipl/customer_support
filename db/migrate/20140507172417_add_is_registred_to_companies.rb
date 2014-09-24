class AddIsRegistredToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :is_registered, :boolean, :default => false
  end
end
