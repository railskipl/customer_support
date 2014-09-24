class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.text :question
      t.text :answer
			t.integer :question_number
      t.timestamps
    end
  end
end
