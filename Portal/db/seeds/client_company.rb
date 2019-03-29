ClientCompany.create(name: "first_company") do |cc|
  cc.client_id = 1
  cc.contact_number = "4853739272"
  cc.address = "Poonamalle"
  cc.city = "Chennai"
  cc.state = "Tamilnadu"
  cc.country = "India"
  cc.zip_code = "600056"
end

ClientCompany.create(name: "second_company") do |cc|
  cc.client_id = 2
  cc.contact_number = "535632828"
  cc.address = "Poonamalle"
  cc.city = "Chennai"
  cc.state = "Tamilnadu"
  cc.country = "India"
  cc.zip_code = "600056"
end
