class ClientSocialNetworksController < ApplicationController
  def index
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
        render pdf: "client_social_networks",disposition: 'attachment'   # Excluding ".pdf" extension.
      end
    end
  end
end
