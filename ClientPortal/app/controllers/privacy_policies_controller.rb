 class PrivacyPoliciesController < ApplicationController

  def index
    @filterrific = initialize_filterrific(
      PrivacyPolicy.client_policy,
      params[:filterrific],
      select_options: {
      sorted_by: PrivacyPolicy.options_for_sorted_by
      }
    ) or return
    @privacy_policies = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @privacy_policies.to_csv }
      format.xls { send_data @privacy_policies.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Policy", disposition: 'attachment',
        # layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end
end
