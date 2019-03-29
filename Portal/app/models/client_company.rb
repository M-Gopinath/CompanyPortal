class ClientCompany < ApplicationRecord
	belongs_to :client
	def address?
		"#{self.try(:address)}, #{self.try(:city)}, #{self.try(:state)}, #{self.try(:country)}, #{self.try(:zip_code)}"
	end

	def client_name?
		self.try(:client).try(:name?)
	end
end
