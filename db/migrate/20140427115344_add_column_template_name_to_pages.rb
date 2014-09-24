class AddColumnTemplateNameToPages < ActiveRecord::Migration
  def change
    add_column :pages, :template_name, :string, :default => 'index'
  end
end
