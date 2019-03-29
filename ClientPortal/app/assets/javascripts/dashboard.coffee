# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#same_as_client_address').change ->
    if $(this).prop('checked')
      contact_number = $('.client_contact_number').html()
      client_address = $('.client_address').html()
      client_city = $('.client_city').html()
      client_state = $('.client_state').html()
      client_country = $('.client_country').html()
      client_zip_code = $('.client_zip_code').html()
      $('#client_company_contact_number').val contact_number
      $('#client_company_address').val client_address
      $('#client_company_city').val client_city
      $('#client_company_state').val client_state
      $('#client_company_country').val client_country
      $('#client_company_zip_code').val client_zip_code
    else
      $('#client_company_contact_number').val ''
      $('#client_company_address').val ''
      $('#client_company_city').val ''
      $('#client_company_state').val ''
      $('#client_company_country').val ''
      $('#client_company_zip_code').val ''
    return
  return