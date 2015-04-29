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
    unless Truck.where(:plate => params[:manifest_report][:plate]).any?
      flash[:error] = "Couldn't find truck with that plate. Create it now"
      redirect_to new_truck_path
    else
      @user = current_user
      @manifest_report = @user.manifest_reports.build(manifest_report_params)
      @manifest_report.project = Project.where(name: params[:manifest_report][:project_name]).first_or_create
      @manifest_report.facility = Facility.where(name: params[:manifest_report][:facility_name]).first_or_create
      truck = @manifest_report.truck
      if truck
        @manifest_report.plate = truck.plate
        @manifest_report.truck_number = truck.number
        # @manifest_report.company = truck.company
      end
      if @manifest_report.save
        flash[:success] = "Report created successfully."
        redirect_to :back
      else
        flash[:error] = @manifest_report.errors.full_messages.to_sentence
        redirect_to :back
      end
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
    s_y = params[:start_date].values[0]
    s_m = params[:start_date].values[1]
    s_d = params[:start_date].values[2]
    e_y = params[:end_date].values[0]
    e_m = params[:end_date].values[1]
    e_d = params[:end_date].values[2]

    start_date = "#{s_y}-#{s_m}-#{s_d}"
    end_date = "#{e_y}-#{e_m}-#{e_d}"
    @reports = ManifestReport.where('date >= ?', Date.parse(start_date)).where('date <= ?', Date.parse(end_date)).where('project_name = ?', params[:project_name])
    respond_to do |format|
      format.xlsx {render xlsx: 'export', filename: "#{Date.today.to_s}.xlsx"}
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
