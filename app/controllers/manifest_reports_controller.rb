class ManifestReportsController < ApplicationController

  def new
    @user = User.first
    @manifest_report = ManifestReport.new
  end

  def index
    @manifest_reports = ManifestReport.all
  end

  def create
    @user = User.first
    @truck = params[:manifest_report][:truck_id]
    @manifest_report = @user.manifest_reports.create(manifest_report_params)

    if @manifest_report.errors.any?
      redirect_to truck_path(@truck), notice: "Please complete all fields."
    else
      redirect_to manifest_reports_path
    end
  end

  private

    def manifest_report_params
      params.require(:manifest_report).permit(
        :user_id, 
        :truck_id, 
        :time_in, 
        :time_out, 
        :manifest_number, 
        :cell, 
        :destination
      )
    end

end
