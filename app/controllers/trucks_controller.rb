class TrucksController < ApplicationController
  before_action :authenticate_user!
  autocomplete :company, :name

  def new
    @truck = Truck.new
    @companies = Company.all
  end

  def create
    @truck = Truck.new(truck_params)
    @truck.company = Company.where(name: params[:truck][:company_name]).first_or_create
    if @truck.save
      flash[:success] = "Truck successfully created"
      if params[:truck][:daily_report_id].present?
        redirect_to new_user_daily_report_manifest_report_path(current_user, params[:truck][:daily_report_id], plate: params[:truck][:plate], cell: params[:truck][:cell], facility_name: params[:truck][:facility_name])
      else
        redirect_to companies_path
      end
    else
      flash[:error] = @truck.errors.full_messages.to_sentence
      redirect_to :back
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
      flash[:error] = @truck.errors.full_messages.to_sentence
      redirect_to :back
    else
      flash[:success] = "Truck successfully updated"
      redirect_to :back
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
