class CompanyDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_company

  def index
    @profile = current_user.company_profile
  end

  def verify_company
    unless current_user&.company?
      redirect_to root_path, alert: "Access denied."
    end
  end
end
