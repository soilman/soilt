class RenameManifestReportDestination < ActiveRecord::Migration
  def change
    rename_column :manifest_reports, :destination, :facility_name
  end
end
