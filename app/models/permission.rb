class Permission < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :admin?
end
