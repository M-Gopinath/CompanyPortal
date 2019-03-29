class ClientCompanyDetailsController < ApplicationController
  def index
    @companies = ClientCompany.joins(:client)
    @filterrific = initialize_filterrific(
      Client.all,
      params[:filterrific],
      select_options: {
      sorted_by: Client.options_for_sorted_by
      }
    ) or return
    @clients = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @clients.to_csv }
      format.xls { send_data @clients.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "client_company_details",disposition: 'attachment'   # Excluding ".pdf" extension.
      end
    end
  end

  def show
    @client = Client.find_by(id: params[:id])
    @client_company = @client.try(:client_company)
  end

  def edit
    @client = Client.find_by(id: params[:id])
    if @client.try(:client_company)
      @client_company = @client.try(:client_company)
    else
      @client_company = ClientCompany.new
    end
  end

  def update_same_address
    @client = Client.find_by(id: params[:id])
    @client.update(client_params)
    if @client.try(:client_company)
      @client_company = @client.try(:client_company)
    else
      @client_company = ClientCompany.new
    end
  end

  def client_update_companies
    @client = Client.find_by(id: params[:id])
    @client_company = @client.client_company
    if @client_company.present?
      @client_company.update(client_company_params)
    else
      @create_client = @client.create_client_company(client_company_params)
    end
    redirect_to client_edit_companies_path(@client)
  end

  def delete
    @client = Client.find_by(id: params[:id])
    @client_company = @client.client_company
    if @client_company.present?
      @client_company.destroy
    end
    redirect_to client_company_details_path
  end

  private

  def client_params
    params.require(:client).permit( :first_name, :last_name, :full_name, :email, :contact_number, :secondary_email, :secondary_contact_number, :address, :city, :state, :country, :zip_code, :is_active, :same_as_client_address)
  end

  def client_company_params
    params.require(:client_company).permit( :client_id, :name, :contact_number, :address, :city, :state, :country, :zip_code)
  end
end
