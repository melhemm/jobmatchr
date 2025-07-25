class EmployeeDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_employee

  def index
    @profile = current_user.employee_profile
  end

  def verify_employee
    unless current_user&.employee?
      redirect_to root_path, alert: "Access denied."
    end
  end
end
