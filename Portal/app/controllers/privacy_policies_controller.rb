 class PrivacyPoliciesController < ApplicationController
	before_action :set_privacy_policy, only: [:show, :edit, :update, :destroy]

  # GET /expenses
  # GET /expenses.json
  def index
    @filterrific = initialize_filterrific(
      PrivacyPolicy.all,
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
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
  	@privacy_policy = PrivacyPolicy.new
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses
  # POST /expenses.json
  def create
  	@privacy_policy = PrivacyPolicy.new(privacy_policy_params)

  	respond_to do |format|
  		if @privacy_policy.save
  			format.html { redirect_to @privacy_policy, notice: 'Privacy Policy was successfully created.' }
  			format.json { render :show, status: :created, location: @privacy_policy }
  		else
  			format.html { render :new }
  			format.json { render json: @privacy_policy.errors, status: :unprocessable_entity }
  		end
  	end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
  	respond_to do |format|
  		if @privacy_policy.update(privacy_policy_params)
  			format.html { redirect_to @privacy_policy, notice: 'Privacy Policy was successfully updated.' }
  			format.json { render :show, status: :ok, location: @privacy_policy }
  		else
  			format.html { render :edit }
  			format.json { render json: @privacy_policy.errors, status: :unprocessable_entity }
  		end
  	end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
  	@privacy_policy.destroy
  	respond_to do |format|
  		format.html { redirect_to privacy_policies_url, notice: 'Privacy Policy was successfully destroyed.' }
  		format.json { head :no_content }
  	end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_privacy_policy
    	@privacy_policy = PrivacyPolicy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def privacy_policy_params
    	params.require(:privacy_policy).permit(:topic, :description)
    end
  end
