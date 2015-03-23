class ManifestReport < ActiveRecord::Base
  belongs_to :user
  belongs_to :truck
  belongs_to :facility
  belongs_to :project

  acts_as_xlsx
end
