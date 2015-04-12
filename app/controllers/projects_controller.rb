class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def new
    @project = Project.new
  end

  def create
    @project = Project.create(project_params)
    if @project.errors.any?
      flash[:error] = "Please complete all fields."
      redirect_to new_project_path
    else
      flash[:success] = "Project created successfully."
      redirect_to root_path
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    @project.update_attributes(project_params)
    if @project.errors.any?
      flash[:error] = "Error. Please try again."
      render 'edit'
    else
      flash[:success] = "Project updated successfully."
      redirect_to :back
    end
  end

  private

    def project_params
      params.require(:project).permit(:name)
    end
end
