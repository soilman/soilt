class ManifestReportsController < ApplicationController
  autocomplete :truck, :plate, :limit => 3
  autocomplete :facility, :name, :limit => 3
  autocomplete :project, :name, :limit => 3
  before_action :authenticate_user!

  def new
    @user = current_user
    @manifest_report = ManifestReport.new
    @daily_report = DailyReport.find(params[:daily_report_id])
    if @daily_report.manifest_reports.any?
      @last_facility = @daily_report.manifest_reports.last.facility.name
    end
  end

  def index
    @user = current_user
    @daily_report = DailyReport.find(params[:daily_report_id])
    @manifest_reports = @daily_report.manifest_reports
  end

  def create
    unless Truck.where(:plate => params[:manifest_report][:plate].upcase).any?
      flash[:error] = "Couldn't find truck with that plate. Create it now"
      redirect_to new_truck_path(
        daily_report_id: params[:daily_report_id],
        plate: params[:manifest_report][:plate].upcase,
        facility_name: params[:manifest_report][:facility_name],
        cell: params[:manifest_report][:cell],
        manifest_number: params[:manifest_report][:manifest_number]
        )
    else
      @daily_report = DailyReport.find(params[:daily_report_id])
      @user = current_user
      @manifest_report = @daily_report.manifest_reports.build(manifest_report_params)
      truck = Truck.where(plate: params[:manifest_report][:plate].upcase).first
      facility = Facility.where(name: params[:manifest_report][:facility_name]).first_or_create
      @manifest_report.truck_id = truck.id
      @manifest_report.facility_id = facility.id
      if truck
        @manifest_report.plate = truck.plate
        @manifest_report.truck_number = truck.number
        # @manifest_report.company = truck.company
      end
      if @manifest_report.save
        flash[:success] = "Load added"
        redirect_to user_daily_report_manifest_reports_path(current_user, @daily_report)
      else
        flash[:error] = @manifest_report.errors.full_messages.to_sentence
        redirect_to :back
      end
    end
  end

  def edit
    @daily_report = DailyReport.find(params[:daily_report_id])
    @user = User.find(params[:user_id])
    @companies = Company.all
    @manifest_report = ManifestReport.find(params[:id])
    @truck = @manifest_report.truck
  end

  def update
    @manifest_report = ManifestReport.find(params[:id])
    @manifest_report.facility = Facility.where(name: params[:manifest_report][:facility_name]).first_or_create
    @manifest_report.update_attributes(manifest_report_params)
    if @manifest_report.errors.any?
      flash[:error] = @manifest_report.errors.full_messages.to_sentence
      render 'edit'
    else
      flash[:success] = "Load updated"
      redirect_to user_daily_report_manifest_reports_path(current_user, params[:daily_report_id])
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
    @reports = ManifestReport.joins(:daily_report).where('daily_reports.date >= ?', Date.parse(start_date)).where('daily_reports.date <= ?', Date.parse(end_date)).where('daily_reports.project_name = ?', params[:project_name])
    # @reports = ManifestReport.where('date >= ?', Date.parse(start_date)).where('date <= ?', Date.parse(end_date)).where('project_name = ?', params[:project_name])
    respond_to do |format|
      format.xlsx {render xlsx: 'export', filename: "#{Date.today.to_s}.xlsx"}
    end
  end

  def destroy
    report = current_user.manifest_reports.where('manifest_reports.id = ?', params[:manifest_report_id]).first

    unless report.try(:destroy)
      flash[:error] = "Error deleting load with id #{params[:manifest_report_id]}"
    else
      flash[:success] = "Load deleted"
    end
    redirect_to :back
  end

  private

    def manifest_report_params
      params.require(:manifest_report).permit(
        :truck_id,
        :time_in,
        :time_out,
        :manifest_number,
        :cell,
        :plate,
        :truck_number,
        :company,
      )
    end
end
