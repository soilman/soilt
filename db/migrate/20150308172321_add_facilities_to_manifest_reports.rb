class AddFacilitiesToManifestReports < ActiveRecord::Migration
  def change
    add_column :manifest_reports, :facility_id, :integer
  end
end
