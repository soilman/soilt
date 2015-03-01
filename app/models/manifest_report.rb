class ManifestReport < ActiveRecord::Base
  belongs_to :user
  belongs_to :truck
end
