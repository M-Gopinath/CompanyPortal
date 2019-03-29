class FinanceManagement::ExpensesController < ApplicationController
  before_action :set_expense, only: [:edit, :update, :destroy]
  def index
    date = params[:date]
    monthly_expense_lists(date)
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @office_expenses.to_csv }
      format.xls { send_data @office_expenses.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Expense Details", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def create
    @office_expense = OfficeExpense.new(office_expense_params)
    if @office_expense.save
      date = @office_expense.spent_date
      monthly_expense_lists(date)
      flash[:success] = "Added New Expense"
    else
      flash[:error] = "Something went wrong"
    end
  end

  def edit

  end

  def update
    if @office_expense.update(office_expense_params)
      date = @office_expense.spent_date
      monthly_expense_lists(date)
      flash[:success] = "Updated Expense"
    else
      flash[:error] = "Something went wrong"
    end
  end

  def destroy
    @office_expense = OfficeExpense.find(params[:id])
    @office_expense.destroy
    date = params[:date]
    monthly_expense_lists(date)
  end

  private

  def office_expense_params
    params.require(:office_expense).permit(:spent_year, :spent_month, :spent_date, :description, :transaction_via_id, :money_spent)
  end

  def set_expense
    @office_expense = OfficeExpense.find(params[:id])
  end

  def monthly_expense_lists(date)
    @date = date.present? ? date.to_date : Time.now
    start_year = @date.beginning_of_year
    end_year = @date.end_of_year
    start_month = @date.beginning_of_month
    end_month = @date.end_of_month
    @office_expenses = OfficeExpense.get_expense_list(start_year, end_year, start_month, end_month).order('created_at DESC')
  end

end
