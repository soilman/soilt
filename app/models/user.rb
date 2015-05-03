class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable#, :rememberable
  has_many :daily_reports
  has_many :manifest_reports, through: :manifest_reports
end
