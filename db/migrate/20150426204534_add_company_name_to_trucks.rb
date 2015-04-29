class AddCompanyNameToTrucks < ActiveRecord::Migration
  def change
    add_column :trucks, :company_name, :string
  end
end
