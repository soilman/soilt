class ManifestReportsController < ApplicationController
  autocomplete :truck, :plate
  autocomplete :facility, :name
  autocomplete :project, :name
  before_action :authenticate_user!

  def new
    @user = current_user
    @manifest_report = ManifestReport.new
  end

  def index
    @user = current_user
    @manifest_reports = ManifestReport.all
  end

  def create
    @user = current_user
    @truck = params[:manifest_report][:truck_id]
    @manifest_report = @user.manifest_reports.create(manifest_report_params)

    if @manifest_report.errors.any?
      redirect_to truck_path(@truck), notice: "Please complete all fields."
    else
      redirect_to root_path
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @companies = Company.all
    @manifest_report = ManifestReport.find(params[:id])
    @truck = @manifest_report.truck
  end

  def update
    @manifest_report = ManifestReport.find(params[:id])
    @manifest_report.update_attributes(manifest_report_params)
    if @manifest_report.errors.any?
      render 'edit', notice: "Error. Please try again."
    else
      redirect_to root_path
      # redirect_to company_truck_path(company, @truck)
    end
  end  

  def export
    binding.pry
    ids = params['exports'].map {|k, v| k.to_i if v == '1'}.compact
    @reports = ManifestReport.where(id: ids)
    respond_to do |format| 
       format.xlsx {render xlsx: 'export',filename: "invoice_#{Date.today.to_s}.xlsx"}
    end
  
  end

  private

    def manifest_report_params
      params.require(:manifest_report).permit(
        :project_name,
        :user_id, 
        :truck_id,
        :facility_id,
        :project_id, 
        :time_in, 
        :time_out, 
        :manifest_number, 
        :cell, 
        :facility_name,
        :plate,
        :truck_number,
        :company,
        :date
      )
    end

end
