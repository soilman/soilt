class DailyReport < ActiveRecord::Base
  has_many :manifest_reports
  belongs_to :project
  belongs_to :user
  validates_presence_of :project, :date
end

