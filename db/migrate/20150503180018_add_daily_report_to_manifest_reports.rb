class AddDailyReportToManifestReports < ActiveRecord::Migration
  def change
    add_column :manifest_reports, :daily_report_id, :integer
  end
end
