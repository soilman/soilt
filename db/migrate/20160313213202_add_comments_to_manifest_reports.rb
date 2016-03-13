class AddCommentsToManifestReports < ActiveRecord::Migration
  def change
    add_column :manifest_reports, :comment, :text
  end
end
