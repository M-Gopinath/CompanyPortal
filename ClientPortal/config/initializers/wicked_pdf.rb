if Rails.env == "production"
	WickedPdf.config = {
		:exe_path => '/home/deploy/.rvm/gems/ruby-2.4.0@employeeportal/bin/wkhtmltopdf'
	}
else
	WickedPdf.config = { :exe_path => "#{ENV['GEM_HOME']}/bin/wkhtmltopdf" }
end