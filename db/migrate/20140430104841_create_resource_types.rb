class CreateResourceTypes < ActiveRecord::Migration
  def change
    create_table :resource_types do |t|
			t.string :name
			t.string :slug
      t.timestamps
    end
    add_index :resource_types, :slug
  end
end
