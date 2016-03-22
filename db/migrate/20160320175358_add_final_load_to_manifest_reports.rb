class AddFinalLoadToManifestReports < ActiveRecord::Migration
  def change
    add_column :manifest_reports, :final_load, :boolean
  end
end
