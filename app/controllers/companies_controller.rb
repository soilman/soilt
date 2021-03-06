class CompaniesController < ApplicationController
  before_action :authenticate_user!

  def index
    @companies = Company.all.sort_by(&:name)
    @company = Company.new
    @truck = Truck.new
  end

  def new
  end

  def create
    name = params[:company][:name].upcase
    @company = Company.create(name: name)
    if @company.errors.any?
      flash[:error] = @company.errors.full_messages.to_sentence
      redirect_to :back
    else
      flash[:success] = "Hauler created successfully."
      redirect_to :back
    end
  end

  def edit
    @company = Company.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @company = Company.find(params[:id])
    name = params[:company][:name].upcase
    @company.update_attributes(name: name)
    if @company.errors.any?
      flash[:error] = @company.errors.full_messages.to_sentence
      render 'edit'
    else
      flash[:success] = "Hauler updated successfully."
      redirect_to :back
    end
  end

  private

    def company_params
      params.require(:company).permit(:name)
    end

end
