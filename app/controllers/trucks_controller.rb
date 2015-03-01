class TrucksController < ApplicationController

  def show 
    @truck = Truck.find(params[:id])
    @manifest_report = ManifestReport.new
    # if current_user
    #   @user = User.find(session[:user_id])
    # end
  end

  def search
    @truck = Truck.find_by(:plate => params[:search].upcase)
    if @truck
      company = @truck.company
      redirect_to company_truck_path(company, @truck)
    else
      redirect_to root_path, notice: "That isn't a valid plate!"
    end
  end
end
