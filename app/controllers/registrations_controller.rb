class RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def new
    @role = params[:role] || 'employee'
    build_resource
    yield resource if block_given?
    respond_with resource
  end

  def create
    build_resource(sign_up_params)
    resource.role = params[:user][:role]

    if resource.save
      sign_up(resource_name, resource)
      redirect_to after_sign_up_path_for(resource)
    else
      clean_up_passwords resource
      @role = params[:user][:role]
      render :new
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end

  def after_sign_up_path_for(resource)
    if resource.company?
      edit_company_profile_path(resource.id)
    else
      edit_employee_profile_path(resource.id)
    end
  end
end
