class UserMonthlyLevBalance
  @queue = :user_queue
  def self.perform
    current_month = Date.today.month
    users = Employee.actived_employees
    users.each do |u|
      begin
        if u.current_month != current_month
          previous_month = current_month - 1
          # For Sick leave
          sick_id = get_leave_type(I18n.t("leave_types.sick_leave"))
          previous_sick = get_previous_details(u, sick_id, previous_month)
          sick_bal = get_previous_month_count(previous_sick, u, sick_id)
          create_user_leaves(u, current_month, sick_id, sick_bal)

          # For Personal Leave
          personal_id = get_leave_type(I18n.t("leave_types.personal_leave"))
          previous_personal = get_previous_details(u, personal_id, previous_month)
          personal_bal = get_previous_month_count(previous_personal, u, personal_id)
          create_user_leaves(u, current_month, personal_id, personal_bal)

          # For Earned Leave
          earned_id = get_leave_type(I18n.t("leave_types.earned_leave"))
          previous_earned = get_previous_details(u, earned_id, previous_month)
          earned_bal = get_previous_count(previous_earned)
          create_user_leaves(u, current_month, earned_id, earned_bal)

          # For Comoff Leave
          comoff_id = get_leave_type(I18n.t("leave_types.comoff_leave"))
          previous_comoff = get_previous_details(u, comoff_id, previous_month)
          comoff_bal = get_previous_count(previous_comoff)
          create_user_leaves(u, current_month, comoff_id, comoff_bal)

          # For Loss of Pay
          lop_id = get_leave_type(I18n.t("leave_types.loss_of_pay"))
          create_user_leaves(u, current_month, lop_id, 0)
          u.update_attributes(current_month: current_month)
          p "Monthly leave balance saved"
        end
      rescue Exception => e
        p "monthly lev Error #{e}"
      end
    end
  end
  def self.get_leave_type(name)
    LeaveType.find_by_name(name).id
  end

  def self.get_previous_month_count(record, user, type_id)
    record.present? ? record.leave_balance : get_yearly_balance_count(user, type_id)
  end

  def self.get_yearly_balance_count(user, type_id)
    current_year = Date.today.year
    user.employee_yearly_leave_balances.find_by(leave_type_id: type_id, year: current_year).try(:leave_balance)
  end

  def self.get_previous_count(record)
    record.present? ? record.leave_balance : 0
  end

  def self.get_previous_details(u, type_id, last_month)
    u.employee_leave_balances.find_by(leave_type_id: type_id, current_month: last_month)
  end

  def self.create_user_leaves(u, current_month, type_id, balance)
    current_year = Date.today.year
    u.employee_leave_balances.create(current_month: current_month, leave_type_id: type_id, leave_balance: balance, current_year: current_year)
  end
end