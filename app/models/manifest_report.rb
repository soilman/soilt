class ManifestReport < ActiveRecord::Base
  belongs_to :user
  belongs_to :truck
  belongs_to :facility
end
