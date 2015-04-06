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
    @manifest_report = @user.manifest_reports.build(manifest_report_params)
    @manifest_report.project = Project.where(name: params[:manifest_report][:project_name]).first_or_create
    @manifest_report.facility = Facility.where(name: params[:manifest_report][:facility_name]).first_or_create
    truck = @manifest_report.truck
    if truck
      @manifest_report.plate = truck.plate
      @manifest_report.truck_number = truck.number
      @manifest_report.company = truck.company
    end
    if @manifest_report.save
      flash[:success] = "Report created successfully."
      redirect_to :back
    else
      flash[:error] = @manifest_report.errors.full_messages.to_sentence
      redirect_to :back
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
      flash[:error] = @manifest_report.errors.full_messages.to_sentence
      render 'edit'
    else
      flash[:success] = "Report updated successfully."
      redirect_to root_path
    end
  end

  def export
    if params['exports']
      ids = params['exports'].map {|k, v| k.to_i if v == '1'}.compact
      @reports = ManifestReport.where(id: ids)
      flash[:success] = "Export successful."
      respond_to do |format|
        format.xlsx {render xlsx: 'export',filename: "invoice_#{Date.today.to_s}.xlsx"}
      end
    else
      flash[:error] = "Please select a report to export."
      redirect_to root_path
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
