class CreateTrucks < ActiveRecord::Migration
  def change
    create_table :trucks do |t|
      t.string :plate
      t.integer :company_id
      t.integer :number
      t.timestamps
    end
  end
end
