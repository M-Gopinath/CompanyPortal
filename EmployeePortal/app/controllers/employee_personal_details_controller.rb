class EmployeePersonalDetailsController < ApplicationController
  def index
    @filterrific = initialize_filterrific(
      Employee.actived_employees,
      params[:filterrific],
      select_options: {
      sorted_by: Employee.options_for_sorted_by
      }
    ) or return
    @actived_employees = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @actived_employees.to_csv }
      format.xls { send_data @actived_employees.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Employee Personal Detail", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def create
    @personal_detail = EmployeePersonalDetail.new(personal_detail_params)
    if @personal_detail.save
      flash[:success] = "Employee Personal Detail Created"
    else
      flash[:error] = "Something Wrong, check your data"
    end
    redirect_to :back
  end

  def update
    @personal_detail = EmployeePersonalDetail.find(params[:id])
    if @personal_detail.update(personal_detail_params)
      flash[:success] = "Employee Personal Detail Updated"
    else
      flash[:error] = "Something Wrong, check your data"
    end
    redirect_to :back
  end

  private

  def personal_detail_params
    params.require(:employee_personal_detail).permit(:employee_id, :personal_email, :contact_number_1, :contact_number_2, :gender, :blood_group, :avatar, :identity_mark_1, :identity_mark_2, :pan_number, :adhaar_card_number, :driving_license_number, :voter_id, :passport_number, :passport_expiry_date, :passport_registration_place)
  end
end
