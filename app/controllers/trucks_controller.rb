class TrucksController < ApplicationController

  def new
    @truck = Truck.new
    @companies = Company.all
  end
  
  def create
    @truck = Truck.create(truck_params)
    company = Company.find(params[:truck][:company_id])
    if @truck.errors.any?
      redirect_to new_truck_path, notice: "Please complete all fields."
    else
      redirect_to company_truck_path(company, @truck)
    end
  end

  def edit
    @truck = Truck.find(params[:id])
    @companies = Company.all
  end

  def update
    @truck = Truck.find(params[:id])
    @truck.update_attributes(truck_params)
    company = Company.find(params[:truck][:company_id])
    if @truck.errors.any?
      render 'edit', notice: "Error. Please try again."
    else
      redirect_to company_truck_path(company, @truck)
    end

  end

  def show 
    @truck = Truck.find(params[:id])
    @manifest_report = ManifestReport.new
    # if current_user
    #   @user = User.find(session[:user_id])
    # end
    @user = User.first
  end

  def search
    @truck = Truck.find_by(:plate => params[:search].upcase)
    if @truck
      company = @truck.company
      redirect_to company_truck_path(company, @truck)
    else
      redirect_to new_truck_path(query: params[:search]), notice: "Truck not found. Create it now."
    end
  end

  private

    def truck_params
      params.require(:truck).permit(
        :company_id, 
        :plate, 
        :number 
      )
    end

end
