class DailyReportsController < ApplicationController

  def index
    @daily_reports = current_user.daily_reports
  end

  def new
    @user = current_user
    @daily_report = DailyReport.new
  end

  def create
    @user = current_user
    @daily_report = @user.daily_reports.build(daily_report_params)
    @daily_report.project = Project.where(name: params[:daily_report][:project_name]).first_or_create
    if @daily_report.save
      flash[:success] = "Report created successfully."
      redirect_to new_user_daily_report_manifest_report_path(@user, @daily_report)
    else
      flash[:error] = @daily_report.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @daily_report = ManifestReport.find(params[:id])
  end

  def update
    @daily_report = DailyReport.find(params[:id])
    @daily_report.date = params[:daily_report][:date]
    @daily_report.project = Project.where(name: params[:daily_report][:project_name]).first_or_create
    if @daily_report.save
      flash[:success] = "Report updated successfully."
      redirect_to root_path
    else
      flash[:error] = @daily_report.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  private

    def daily_report_params
      params.require(:daily_report).permit(
        :project_name,
        :date
      )
    end
end
