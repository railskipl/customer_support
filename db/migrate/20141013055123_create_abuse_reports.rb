class CreateAbuseReports < ActiveRecord::Migration
  def change
    create_table :abuse_reports do |t|
      t.string :user_email
      t.text :message
      t.string :first_name
      t.string :last_name
      t.string :subject

      t.timestamps
    end
  end
end
