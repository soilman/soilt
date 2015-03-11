class AddProjectNameToManifestReports < ActiveRecord::Migration
  def change
    add_column :manifest_reports, :project_name, :string
  end
end
