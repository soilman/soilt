class Truck < ActiveRecord::Base
  belongs_to :company
  has_many :manifest_reports
  has_many :projects, through: :manifest_reports
  has_many :facilities, through: :manifest_reports
  
end
