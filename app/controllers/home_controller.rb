class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    # @last_facility = current_user.manifest_reports.last.facility_name
  end
end

