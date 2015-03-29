class ManifestReport < ActiveRecord::Base
  belongs_to :user
  belongs_to :truck
  belongs_to :facility
  belongs_to :project

  validates_presence_of :time_in, :time_out, :manifest_number, :cell, :facility_name, :plate, :truck_number, :company, :date, :project_name
  validates_uniqueness_of :manifest_number

  acts_as_xlsx
end
