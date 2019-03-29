class FinanceManagement::OfficeIncomesController < ApplicationController

  def index
    @date = params[:date].present? ? params[:date].to_date : Time.now
    start_year = @date.beginning_of_year
    end_year = @date.end_of_year
    start_month = @date.beginning_of_month
    end_month = @date.end_of_month
    @office_incomes = OfficeIncome.includes(:client).get_income_list(start_year, end_year, start_month, end_month).order('office_incomes.created_at DESC')
    @clients = @office_incomes.collect(&:client).compact
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @office_incomes.to_csv(@clients, @date) }
      format.xls { send_data @office_incomes.to_csv(@clients, @date, col_sep: "\t") }
      format.pdf do
        render pdf: "Expense Details", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def create
    @office_income = OfficeIncome.new(office_income_params)
    if @office_income.save
      flash[:success] = "Sucessfully created new income"
    else
      flash[:error] = "Something went wrong"
    end
    redirect_to :back
  end

  def update
    @office_income = OfficeIncome.find(params[:id])
    if @office_income.update(office_income_params)
      flash[:success] = "Sucessfully Updated"
    else
      flash[:error] = "Something went wrong"
    end
    redirect_to :back
  end

  def destroy
    @office_income = OfficeIncome.find(params[:id])
    @office_income.destroy
    redirect_to :back
  end

  def income_client
    client = Client.find(params[:client_id])
    @projects = client.projects
  end

  private
  def office_income_params
    params.require(:office_income).permit(:client_id, :project_id, :transaction_via_id, :money_received_month, :money_received_year, :money_received_date, :money_received)
  end
end
