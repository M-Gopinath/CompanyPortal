class ClientListingsController < ApplicationController
  def active_clients
    @filterrific = initialize_filterrific(
      Client.active_clients,
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
        render pdf: "client_listings",disposition: 'attachment'   # Excluding ".pdf" extension.
      end
    end
  end

  def deactive_clients
    @filterrific = initialize_filterrific(
      Client.deactive_clients,
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
        render pdf: "client_listings",disposition: 'attachment'   # Excluding ".pdf" extension.
      end
    end
  end

  def update_is_active
    @client = Client.find_by(id: params[:id])
    url_generate
    respond_to do |format|
      if @client.update_attributes(is_active: !@client.is_active)
        format.html { redirect_to @url, notice: 'Active update Sucessfully' }
      else
        format.html { redirect_to @url, notice: 'Active update Sucessfully' }
      end
    end
  end

  def create
    @client = Client.new(client_params)
    password_generate
    @client.save
    redirect_to active_clients_path
  end

  def show
    
  end

  def edit
    @client = Client.find_by(id: params[:id])
  end

  def update
    @client = Client.find_by(id: params[:id])
    url_generate
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @url, notice: 'Client update Sucessfully' }
      else
      end
    end
  end

  def delete
    @client = Client.find_by(id: params[:id])
    url_generate
    @client.destroy
    redirect_to @url
  end

  def url_generate
    @url = @client.try(:is_active).present? ? active_clients_path : deactive_clients_path
  end

  def password_generate
    seed = "--#{rand(10000000)}--#{Time.now}--#{rand(10000000)}"
    secure_password = Digest::SHA1.hexdigest(seed)[0,8]
    @client.password = secure_password
    @client.password_confirmation = secure_password
  end

  private

  def client_params
    params.require(:client).permit( :first_name, :last_name, :full_name, :email, :contact_number, :secondary_email, :secondary_contact_number, :address, :city, :state, :country, :zip_code, :is_active, :same_as_client_address)
  end

  def client_company_params
    params.require(:client_company).permit( :client_id, :name, :contact_number, :address, :city, :state, :country, :zip_code)
  end
end
