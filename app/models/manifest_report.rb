class ManifestReport < ActiveRecord::Base
  belongs_to :user
  belongs_to :truck
  has_one :company, :through => :truck
  belongs_to :facility, :autosave => true
  belongs_to :project, :autosave => true

  accepts_nested_attributes_for :project
  accepts_nested_attributes_for :facility

  validates_presence_of :time_in, :time_out, :manifest_number, :cell, :plate, :truck_number, :company, :date, :truck
  validates_uniqueness_of :manifest_number

  acts_as_xlsx

  # to validate the associated record, you can add a method like this:
  #     validate_associated_record_for_author
  # def autosave_associated_records_for_project
  #   # Find or create the project by name
  #   binding.pry
  #   if new_project = Project.find_by_name(project_name)
  #     self.project = new_project
  #   else
  #     self.project.save!
  #     self.project_id = self.project.id
  #   end
  # end
end
