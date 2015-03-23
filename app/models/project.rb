class Project < ActiveRecord::Base
  has_many :manifest_reports
  has_many :trucks, through: :manifest_reports
  has_many :facilities, through: :manifest_reports

  validates_presence_of :name
end
