class Truck < ActiveRecord::Base
  belongs_to :company
  has_many :manifest_reports
end
