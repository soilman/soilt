class FacilitiesController < ApplicationController

  def new
    @facility = Facility.new
  end

end
