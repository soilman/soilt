class Company < ActiveRecord::Base
  has_many :trucks
  has_many :manifest_reports, through: :trucks
end
