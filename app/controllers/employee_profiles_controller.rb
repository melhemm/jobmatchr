class EmployeeProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_employee

  def edit
    @profile = current_user.employee_profile
  end

  def update
    @profile = current_user.employee_profile
    if @profile.update(employee_profile_params)
      redirect_to employee_root_path, notice: 'Profile updated successfully'
    else
      render :edit
    end
  end

  private

  def employee_profile_params
    params.require(:employee_profile).permit(:first_name, :last_name, :address, :skills, :resume_url)
  end

  def verify_employee
    redirect_to root_path, alert: "Access denied" unless current_user.employee?
  end
end
