class AddUserToDailyReports < ActiveRecord::Migration
  def change
    add_column :daily_reports, :user_id, :integer
  end
end
