class ManifestReport < ActiveRecord::Base
  belongs_to :daily_report
  belongs_to :user
  belongs_to :truck
  has_one :company, :through => :truck
  belongs_to :facility, :autosave => true

  #accepts_nested_attributes_for :project
  accepts_nested_attributes_for :facility

  validates_presence_of :time_in, :time_out, :manifest_number, :cell, :plate, :truck, :facility
  validate :manifest_number_uniqueness, :on => :create

  acts_as_xlsx

  private
    def manifest_number_uniqueness
      if self.daily_report.manifest_reports.pluck(:manifest_number).include?(self.manifest_number)
        errors.add(:manifest_number, "has already been taken")
      end
    end


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
