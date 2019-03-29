class DashboardController < ApplicationController
  def index
  end

  def edit_profile
  	@client = current_client
  end

  def company
  	@client = current_client
    if @client.try(:client_company)
      @client_company = @client.try(:client_company)
    else
      @client_company = ClientCompany.new
    end
  end

  def update_client
  	@client = current_client
  	@client.update(client_params)
  	redirect_to dashboard_edit_profile_path
  end

  def update_same_address
    @client = current_client
    @client.update(client_params)
    if @client.try(:client_company)
      @client_company = @client.try(:client_company)
    else
      @client_company = ClientCompany.new
    end
  end

  def create_client_company
  	@client = current_client
    @client_company = @client.client_company
    if @client_company.present?
      @client_company.update(client_company_params)
    else
  	 @create_client = @client.create_client_company(client_company_params)
    end
  	redirect_to dashboard_company_path
  end

  private

  def client_params
  	params.require(:client).permit( :first_name, :last_name, :full_name, :contact_number, :secondary_email, :secondary_contact_number, :address, :city, :state, :country, :zip_code, :is_active, :same_as_client_address)
  end

  def client_company_params
  	params.require(:client_company).permit( :client_id, :name, :contact_number, :address, :city, :state, :country, :zip_code)
  end
end
