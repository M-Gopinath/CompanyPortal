class UserYearlyLevBalance
  @queue = :user_queue
  def self.perform
    current_year = Date.today.year
    users = Employee.actived_employees
    users.each do |u|
      begin
        if u.current_year != current_year
          u.employee_yearly_leave_balances.create(year: current_year, leave_type_id: get_leave_type(I18n.t("leave_types.sick_leave")), leave_balance: 6)
          u.employee_yearly_leave_balances.create(year: current_year, leave_type_id: get_leave_type(I18n.t("leave_types.personal_leave")), leave_balance: 6)
          u.update_attributes(current_year: current_year)
          p "Yearly leave balance saved"
        else
          p "Yearly leave balance already created"
        end
      rescue Exception => e
        p "Yearly Error #{e}"
      end
    end
  end

  def self.get_leave_type(name)
    LeaveType.find_by_name(name).id
  end
end