class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_employee!, :redirect_unless_admin,  only: [:new, :create, :destroy_employee]
  skip_before_action :require_no_authentication


  def check_employee
    emp = Employee.where(first_name: params[:first_name], last_name: params[:last_name] )
    password = SecureRandom.base64(5)
    if emp.count > 0
      new_email = "#{params[:first_name]}.#{params[:last_name]}#{emp.count}"
      render json: {success: true, email: new_email, password: password}
    else
      new_email = "#{params[:first_name]}.#{params[:last_name]}"
      render json: {success: true, email: new_email, password: password}
    end
  end

  def destroy_employee
    emp = Employee.find(params[:id])
    emp.destroy
    redirect_to admin_dashboard_path
  end

  def update
    resource = Employee.find_by_email(params[:employee][:email])
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def assign_supervisor
    @role = Role.find(params[:role_id])
    if @role.manager? || @role.team_lead?
      @employees = Employee.where(role_id: 3)
    elsif @role.software_engineers?
      @employees = Employee.where(role_id: [3,4])
    else
      @employees = []
    end
  end

  private

  def redirect_unless_admin
    unless employee_signed_in? && current_employee.admin?
      flash[:error] = "Only admins can do that"
      redirect_to root_path
    end
  end

  def sign_up(resource_name, resource)
    true
  end

  def after_sign_up_path_for(resource)
    redirect_to :back
  end

  def after_inactive_sign_up_path_for(resource)
    if params[:employee][:seed_table]
      '/seed_table/employee'
    else
      '/employees/active'
    end
  end


  def sign_up_params
    params.require(:employee).permit(:title, :first_name, :last_name, :full_name, :dob, :role_id, :supervisor_id,  :email, :first_password, :password, :password_confirmation, :is_active, :ctc)
  end

  def account_update_params
    params.require(:employee).permit(:title, :first_name, :last_name, :full_name, :dob, :role_id, :supervisor_id, :email, :first_password, :password, :password_confirmation, :is_active, :ctc)
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    active_employees_path
  end

end