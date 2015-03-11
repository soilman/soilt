class AddDateToManifestReports < ActiveRecord::Migration
  def change
    add_column :manifest_reports, :date, :date
  end
end
