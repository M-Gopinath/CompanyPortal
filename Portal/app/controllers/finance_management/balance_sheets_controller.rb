class FinanceManagement::BalanceSheetsController < ApplicationController
  def index
    @date = params[:date].present? ? params[:date].to_date : Time.now
    @balance_sheet = BalanceSheet.find_by(month_year: @date.beginning_of_month)
  end

  def shareholder_profit_loss
     @date = params[:date].present? ? params[:date].to_date : Time.now
    @next_year = params[:next_year].present? ? params[:next_year].to_date : @date.next_year
    start_year = @date.beginning_of_year
    end_year = @date.next_year.beginning_of_year
    start_month = start_year + 3.months #@date.beginning_of_month
    end_month = end_year + 2.months
    @balance_sheets = BalanceSheet.get_balancesheet_list(start_year, end_year, start_month, end_month)
  end
end
