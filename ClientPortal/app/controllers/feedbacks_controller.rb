class FeedbacksController < ApplicationController
	def index
		@filterrific = initialize_filterrific(
      current_client.feedbacks.all,
      params[:filterrific],
      select_options: {
      sorted_by: current_client.feedbacks.options_for_sorted_by
      }
    ) or return
		@feedbacks = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
		respond_to do |format|
			format.html
			format.js
			format.csv { send_data @feedbacks.to_csv }
			format.xls { send_data @feedbacks.to_csv(col_sep: "\t") }
			format.pdf do
				render pdf: "Feedbacks", disposition: 'attachment',
				# layout: 'layouts/pdf_layout.html.erb',
				:page_size => 'A4',
				:margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
			end
		end
		@feedback = Feedback.new
	end

	def edit
		@feedback = Feedback.find_by(id: params[:id])
	end

  def create_feedback
  	@create_feedback = current_client.feedbacks.create(feedback_params)
  	@create_feedback.save
		redirect_to feedbacks_path
  end

  def update_feedback
  	@update_feedback = Feedback.find_by(id: params[:id])
  	@update_feedback.update(feedback_params)
		redirect_to feedbacks_path
  end

  def project_employee
  	p @project_employee = ProjectEmployee.where(project_id: params[:project_id])
  end

	def remove_feedback
		@feedback = Feedback.find_by(id: params[:feedback_id])
		@feedback.destroy
		redirect_to feedbacks_path
	end

	private

	def feedback_params
		params.require(:feedback).permit(:project_id, :client_id, :feedback, :employee_id)
	end
end
