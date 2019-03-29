class OfficeIncome < ApplicationRecord
  extend FinanceManagementHelper
  include FinanceManagementHelper
  belongs_to :client
  belongs_to :project
  belongs_to :transaction_via, class_name: 'TransactionVium', foreign_key: 'transaction_via_id'
  before_save :set_month_date
  after_save :send_income_notify


  def set_month_date
    self.money_received_month = self.money_received_date.month
    self.money_received_year = self.money_received_date.year
  end

  def self.get_income_list(start_year, end_year, start_month, end_month)
    self.where('money_received_date >= ? && money_received_date <= ? && money_received_date >= ? && money_received_date <= ?', start_year, end_year, start_month, end_month)
  end

  def self.to_csv(clients, date, options = {})
    CSV.generate(options) do |csv|
      #Total
      @other_total = ["#{Date::MONTHNAMES[date.month]} #{date.strftime("%Y")}", get_income(all, "OFFICE"), get_income(all, "GOPINATH"), get_income(all, "SARAVANAN"), get_income(all, "OTHERS"), get_all_income(all)]
      @client_total = []
      clients.uniq.each do |c|
        @client_total << get_client_income(c, @office_incomes)
      end
      @full_total = @other_total + @client_total
      csv << @full_total
      #Header
      @clients = clients.uniq.collect(&:first_name)
      @others = ["Money Received Date", "Money Holding By Office", "Money Holding By Gopi", "Money Holding By Saravanan", "Money Holding By Other", "Total Amount"]
      @headers = @others + @clients
      csv << @headers
      # Values
      all.each do |i|
        @other_values = [i.money_received_date.strftime("%b %d"), holding_income(i, "OFFICE"), holding_income(i, "GOPINATH"), holding_income(i, "SARAVANAN"), holding_income(i, "OTHERS"), i.money_received]
        @client_values = []
        clients.uniq.each do |c|
          c.id == i.client_id ? @client_values << i.money_received : @client_values << ""
        end
        @body = @other_values + @client_values
        csv << @body
      end
    end
  end

  def send_income_notify
    # FinanceMailer.notify_income(self).deliver_now
    begin 
      @date = self.money_received_date
      start_year = @date.beginning_of_year
      end_year = @date.end_of_year
      start_month = @date.beginning_of_month
      end_month = @date.end_of_month
      @office_incomes = OfficeIncome.get_income_list(start_year, end_year, start_month, end_month)
      @office_expense = OfficeExpense.get_expense_list(start_year, end_year, start_month, end_month)
      @total_income = @office_incomes.collect(&:money_received).compact.sum
      @total_expense = @office_expense.collect(&:money_spent).compact.sum
      @monthly_ctc = EmployeeCtcMonthly.get_monthly_earnings(@date.beginning_of_month)
      @net_salary = @monthly_ctc.collect(&:net_salary).compact.sum
      @total_net_salary = (Employee.actived_employees.collect(&:ctc).compact.sum)/12
      @total_diff = @total_net_salary - @net_salary
      @off_share = (@total_income*50)/100
      @gopi_share = (@total_income*30)/100
      @saran_share = (@total_income*20)/100
      @office_pl = @off_share - (@total_expense + over_all_monthly_net_pay(start_month))
      @gopi_pl = @office_pl/2
      @saran_pl = @office_pl/2
      amt_received_gopi = @office_incomes.where(transaction_via_id: transaction_via_amount("GOPINATH"))
      @received_gopi = amt_received_gopi.collect(&:money_received).compact.sum
      amt_received_saran = @office_incomes.where(transaction_via_id: transaction_via_amount("SARAVANAN"))
      @received_saran = amt_received_saran.collect(&:money_received).compact.sum
      # amt_received_office = @office_incomes.where(transaction_via_amount_id: transaction_via_amount()"OFFICE")
      # @received_office = amt_received_saran.collect(&:money_received).compact.sum
      amt_spent_gopi = @office_expense.where(transaction_via_id: transaction_via_amount("GOPINATH"))
      @spent_gopi = amt_spent_gopi.collect(&:money_spent).compact.sum

      amt_spent_saran = @office_expense.where(transaction_via_id: transaction_via_amount("SARAVANAN"))
      @spent_saran = amt_spent_saran.collect(&:money_spent).compact.sum
      balance_to_gopi = @received_gopi - @spent_gopi
      balance_to_saran = @received_saran - @spent_saran
      gopi_total_pay = (@spent_gopi + @gopi_share) - @received_gopi
      saran_total_pay = (@spent_saran + @saran_share) - @received_saran
      final_total_pay_to_gopi = @gopi_pl + gopi_total_pay
      final_total_pay_to_saran = @saran_pl + saran_total_pay

      @balance_sheet = BalanceSheet.find_by(month_year: self.money_received_date.beginning_of_month)
      if @balance_sheet.present?
        @balance_sheet.update_attributes(month_year: @date.beginning_of_month, office_income: @total_income, office_expense: @total_expense, office_net_salary: @net_salary, office_overall_salary: @total_net_salary, diff_net_overall_salary: @total_diff, office_share: @off_share, gopi_share: @gopi_share, saran_share: @saran_share, office_profit_loss: @office_pl, gopi_profit_loss: @gopi_pl, saran_profit_loss: @saran_pl, amount_received_by_gopi: @received_gopi, amount_received_by_saran: @received_saran, amount_spent_by_gopi: @spent_gopi, amount_spent_by_saran: @spent_saran, balance_money_to_gopi: balance_to_gopi, balance_money_to_saran: balance_to_saran, gopi_total_pay: gopi_total_pay, saran_total_pay: saran_total_pay, final_total_pay_to_gopi: final_total_pay_to_gopi, final_total_pay_to_saran: final_total_pay_to_saran)
      else
        BalanceSheet.create(month_year: @date.beginning_of_month, office_income: @total_income, office_expense: @total_expense, office_net_salary: @net_salary, office_overall_salary: @total_net_salary, diff_net_overall_salary: @total_diff, office_share: @off_share, gopi_share: @gopi_share, saran_share: @saran_share, office_profit_loss: @office_pl, gopi_profit_loss: @gopi_pl, saran_profit_loss: @saran_pl, amount_received_by_gopi: @received_gopi, amount_received_by_saran: @received_saran, amount_spent_by_gopi: @spent_gopi, amount_spent_by_saran: @spent_saran, balance_money_to_gopi: balance_to_gopi, balance_money_to_saran: balance_to_saran, gopi_total_pay: gopi_total_pay, saran_total_pay: saran_total_pay, final_total_pay_to_gopi: final_total_pay_to_gopi, final_total_pay_to_saran: final_total_pay_to_saran)
      end
      p "Saved"
    rescue Exception => e
      p "Balance sheet error #{e}"
    end
  end

  private

  def transaction_via_amount(name)
    TransactionVium.find_by(name: name).try(:id)
  end
end
