class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.boolean :admin?
      t.integer :user_id

      t.timestamps
    end
  end
end
