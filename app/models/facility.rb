class Facility < ActiveRecord::Base
  has_many :manifest_reports
  has_many :trucks, through: :manifest_reports
  has_many :projects, through: :manifest_reports

  validates_presence_of :name
  validates_uniqueness_of :name
end
