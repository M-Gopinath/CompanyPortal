class LeavePermissionsController < ApplicationController
  before_action :approve_permission_request_cal, only: [:permission_approve]
  before_action :cancel_permission_request_cal, only: [:permission_cancel]
  before_action :reject_permission_request_cal, only: [:permission_reject]
  before_action :cancel_leave_request_cal, only: [:leave_cancel]
  before_action :reject_leave_request_cal, only: [:leave_reject]
  def leave_approve
    @date = params[:date].present? ? params[:date].to_date : Time.now
    start_year = @date.beginning_of_year
    end_year = @date.end_of_year
    start_month = @date.beginning_of_month
    end_month = @date.end_of_month
    @filterrific = initialize_filterrific(
      LeaveRequest.get_approve_leave_request(start_year, end_year, start_month, end_month),
      params[:filterrific],
      select_options: {
      sorted_by: LeaveRequest.options_for_sorted_by
      }
    ) or return
    @approve_permission_request = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @approve_permission_request.to_csv }
      format.xls { send_data @approve_permission_request.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Permission Approve List", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def leave_cancel
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @cancel_permission_request.to_csv }
      format.xls { send_data @cancel_permission_request.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Permission Cancel List", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def leave_reject
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @reject_leave_request.to_csv }
      format.xls { send_data @reject_leave_request.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Permission Approve List", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def leave_destroy
    @leave = LeaveRequest.find_by(id: params[:leave_id])
    @leave.destroy
    redirect_to :back
  end

  def permission_destroy
    @permission = PermissionRequest.find_by(id: params[:permission_id])
    @permission.destroy
    redirect_to :back
  end

  def permission_approve
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @approve_permission_request.to_csv }
      format.xls { send_data @approve_permission_request.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Permission Approve List", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def permission_cancel
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @cancel_permission_request.to_csv }
      format.xls { send_data @cancel_permission_request.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Permission Cancel List", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def permission_reject
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @reject_permission_request.to_csv }
      format.xls { send_data @reject_permission_request.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Permission Reject List", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  private

  def leave_request_cal
    @date = params[:date].present? ? params[:date].to_date : Time.now
    start_year = @date.beginning_of_year
    end_year = @date.end_of_year
    start_month = @date.beginning_of_month
    end_month = @date.end_of_month
    @filterrific = initialize_filterrific(
      LeaveRequest.get_requests(start_year, end_year, start_month, end_month),
      params[:filterrific],
      select_options: {
      sorted_by: LeaveRequest.options_for_sorted_by
      }
    ) or return
    @permission_request = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
  end

  def permission_request_cal
    @date = params[:date].present? ? params[:date].to_date : Time.now
    start_year = @date.beginning_of_year
    end_year = @date.end_of_year
    start_month = @date.beginning_of_month
    end_month = @date.end_of_month
    @filterrific = initialize_filterrific(
      PermissionRequest.get_permission_request(start_year, end_year, start_month, end_month),
      params[:filterrific],
      select_options: {
      sorted_by: PermissionRequest.options_for_sorted_by
      }
    ) or return
    @permission_list_calendars = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
  end

  def approve_permission_request_cal
    @date = params[:date].present? ? params[:date].to_date : Time.now
    start_year = @date.beginning_of_year
    end_year = @date.end_of_year
    start_month = @date.beginning_of_month
    end_month = @date.end_of_month
    @filterrific = initialize_filterrific(
      PermissionRequest.get_approve_permission_request(start_year, end_year, start_month, end_month),
      params[:filterrific],
      select_options: {
      sorted_by: PermissionRequest.options_for_sorted_by
      }
    ) or return
    @approve_permission_request = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
  end

  def cancel_permission_request_cal
    @date = params[:date].present? ? params[:date].to_date : Time.now
    start_year = @date.beginning_of_year
    end_year = @date.end_of_year
    start_month = @date.beginning_of_month
    end_month = @date.end_of_month
    @filterrific = initialize_filterrific(
      PermissionRequest.get_cancel_permission_request(start_year, end_year, start_month, end_month),
      params[:filterrific],
      select_options: {
      sorted_by: PermissionRequest.options_for_sorted_by
      }
    ) or return
    @cancel_permission_request = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
  end

  def reject_permission_request_cal
    @date = params[:date].present? ? params[:date].to_date : Time.now
    start_year = @date.beginning_of_year
    end_year = @date.end_of_year
    start_month = @date.beginning_of_month
    end_month = @date.end_of_month
    @filterrific = initialize_filterrific(
      PermissionRequest.get_reject_permission_request(start_year, end_year, start_month, end_month),
      params[:filterrific],
      select_options: {
      sorted_by: PermissionRequest.options_for_sorted_by
      }
    ) or return
    @reject_permission_request = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
  end

  def cancel_leave_request_cal
    @date = params[:date].present? ? params[:date].to_date : Time.now
    start_year = @date.beginning_of_year
    end_year = @date.end_of_year
    start_month = @date.beginning_of_month
    end_month = @date.end_of_month
    @filterrific = initialize_filterrific(
      LeaveRequest.get_cancel_leave_request(start_year, end_year, start_month, end_month),
      params[:filterrific],
      select_options: {
      sorted_by: LeaveRequest.options_for_sorted_by
      }
    ) or return
    @cancel_permission_request = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
  end

  def reject_leave_request_cal
    @date = params[:date].present? ? params[:date].to_date : Time.now
    start_year = @date.beginning_of_year
    end_year = @date.end_of_year
    start_month = @date.beginning_of_month
    end_month = @date.end_of_month
    @filterrific = initialize_filterrific(
      LeaveRequest.get_reject_leave_request(start_year, end_year, start_month, end_month),
      params[:filterrific],
      select_options: {
      sorted_by: LeaveRequest.options_for_sorted_by
      }
    ) or return
    @reject_leave_request = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
  end
end
