# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'change', '#employee_professional_detail_to_date', ->
  console.log("sedfsdsd");
  user_id = $(this).data('user_id');
  from_date = $(".from_pro_" + user_id).datepicker("getDate");
  to_date = $(".to_pro_" + user_id).datepicker("getDate");
  if from_date && to_date
    if from_date > to_date
      alert("To Date is less than From Date");
      $(this).val('');