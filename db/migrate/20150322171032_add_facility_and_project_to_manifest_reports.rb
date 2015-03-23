class AddFacilityAndProjectToManifestReports < ActiveRecord::Migration
  def change
    add_column :manifest_reports, :project_id, :integer
  end
end
