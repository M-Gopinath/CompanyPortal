class EmployeeAgreementsController < ApplicationController
  before_action :set_employee, only: [:bond_letter, :experience_letter, :relieving_letter, :resignation_letter, :joining_letter]
  def index
    @filterrific = initialize_filterrific(
      Employee.actived_employees,
      params[:filterrific],
      select_options: {
      sorted_by: Employee.options_for_sorted_by
      }
    ) or return
    @employees = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @employees.to_csv }
      format.xls { send_data @employees.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Employee Address", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def bond_letter
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "BondLetter", disposition: 'attachment',
        layout: 'layouts/pdf_agreements_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def experience_letter
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "ExperienceLetter", disposition: 'attachment',
        layout: 'layouts/pdf_agreements_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def relieving_letter
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "RelievingLetter", disposition: 'attachment',
        layout: 'layouts/pdf_agreements_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def resignation_letter
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "ResignationLetter", disposition: 'attachment',
        layout: 'layouts/pdf_agreements_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def joining_letter
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "JoiningLetter", disposition: 'attachment',
        layout: 'layouts/pdf_agreements_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  private
  def set_employee
    @employee = Employee.find(params[:employee_id])
  end

end
