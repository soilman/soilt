class FacilitiesController < ApplicationController
  before_action :authenticate_user!

  def new
    @facility = Facility.new
  end

  def create
    @facility = Facility.create(facility_params)
    if @facility.errors.any?
      flash[:error] = "Please complete all fields."
      redirect_to new_facility_path
    else
      flash[:success] = "Facility created successfully."
      redirect_to root_path
    end
  end

  def edit
    @facility = Facility.find(params[:id])
  end

  def update
    @facility = Facility.find(params[:id])
    @facility.update_attributes(facility_params)
    if @facility.errors.any?
      flash[:error] = "Error. Please try again."
      render 'edit'
    else
      flash[:success] = "Facility updated successfully."
      redirect_to :back
    end
  end

  # def show
  #   @truck = Truck.find(params[:id])
  #   @manifest_report = ManifestReport.new
  #   # if current_user
  #   #   @user = User.find(session[:user_id])
  #   # end
  #   @user = User.first
  # end

  private

    def facility_params
      params.require(:facility).permit(:name)
    end
end
