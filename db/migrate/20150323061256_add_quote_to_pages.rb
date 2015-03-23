class AddQuoteToPages < ActiveRecord::Migration
  def change
    add_column :pages, :quote, :text
  end
end
