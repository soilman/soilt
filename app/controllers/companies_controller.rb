class CompaniesController < ApplicationController

  def new
    @company = Company.new
  end

  def create
    @company = Company.create(company_params)
    if @company.errors.any?
      flash[:error] = "Please complete all fields."
      redirect_to new_company_path
    else
      flash[:success] = "Company created successfully."
      redirect_to root_path
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    @company.update_attributes(company_params)
    if @company.errors.any?
      flash[:error] = "Error. Please try again."
      render 'edit'
    else
      flash[:success] = "Company updated successfully."
      redirect_to :back
    end
  end

  private

    def company_params
      params.require(:company).permit(:name)
    end

end
