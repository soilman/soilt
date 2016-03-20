class AddStatusToDailyReports < ActiveRecord::Migration
  def change
    add_column :daily_reports, :complete, :boolean
  end
end
