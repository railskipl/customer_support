class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :slug
      t.string :title
      t.string :subtitle
      t.text :description
      t.string :image

      t.timestamps
    end
  end
end
