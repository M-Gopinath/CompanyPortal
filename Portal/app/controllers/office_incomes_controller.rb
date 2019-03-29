class OfficeIncomesController < ApplicationController
  def create
    @office_income = OfficeIncome.new(office_income_params)
    if @office_income.save
      flash[:success] = "Sucessfully create new income"
    else
      flash[:error] = "Something went wrong"
    end
    redirect_to :back
  end

  private
  def office_income_params
    params.require(:office_income).permit(:client_id, :project_id, :transaction_via_id, :money_received_month, :money_received_year, :money_received_date, :money_received)
  end
end
