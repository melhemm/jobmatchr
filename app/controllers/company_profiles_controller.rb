class CompanyProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_company

  def edit
    @profile = current_user.company_profile
  end

  def update
    @profile = current_user.company_profile
    if @profile.update(company_profile_params)
      redirect_to company_root_path, notice: 'Profile updated successfully'
    else
      render :edit
    end
  end

  private

  def company_profile_params
    params.require(:company_profile).permit(:name, :address, :website, :description)
  end

  def verify_company
    redirect_to root_path, alert: "Access denied" unless current_user.company?
  end
end
