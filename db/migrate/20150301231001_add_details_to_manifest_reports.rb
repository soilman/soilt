class AddDetailsToManifestReports < ActiveRecord::Migration
  def change
    add_column :manifest_reports, :plate, :string
    add_column :manifest_reports, :truck_number, :integer
    add_column :manifest_reports, :company, :string
  end
end
