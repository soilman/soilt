class CreateDailyReports < ActiveRecord::Migration
  def change
    create_table :daily_reports do |t|
      t.date :date
      t.integer :project_id
      t.string :project_name

      t.timestamps
    end
  end
end
