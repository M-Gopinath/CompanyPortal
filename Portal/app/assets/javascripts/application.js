// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.dataTables.min
//= require jquery_ujs
//= require bootstrap.min
//= require dataTables.bootstrap.min
//= require app
//= require cable
//= require jquery.slimscroll.min
//= require bootstrap-datepicker
//= require jquery.timepicker.js
//= require fastclick
//= require jquery.remotipart
//= require tags/typeahead.bundle
//= require tags/typeahead.bundle.min
//= require tags/mab-jquery-taginput

$(document).on('keyup','.filterrific-periodically-observed', function(){
  var data = $(this).closest("form").submit();
});

$(document).on('change keyup', '.employee_last_name, .employee_first_name', function(){
  var first_name = $('.employee_first_name').val();
  var last_name = $('.employee_last_name').val();
  $.ajax({
    url: '/check_employee',
    data: {first_name: first_name, last_name: last_name},
  })
  .done(function(data) {
    $('.employee_email').val(data.email);
    $('.employee_password').val(data.password);
    $('.employee_password_confirmation').val(data.password);
    $('.employee_first_password').val(data.password);
  });
});

$(document).on("focus", ".datepicker", function(){
  $(this).datepicker({
    todayHighlight:'TRUE',
    startDate: '-0d',
    endDate: '+2m',
    format: 'dd-mm-yyyy',
    autoclose: true
  });
});

$('.timepicker').timepicker({ 'scrollDefault': 'now' });

$(document).on("focus", ".datepicker-user", function(){
  $(this).datepicker({
    startView: "decade",
    startDate: '-50y',
    endDate: '-1y',
    format: 'yyyy-mm-dd',
    autoclose: true
  });
});
$(document).on('change', '#employee_role_id', function(){
  var roleId = $(this).val();
  $.ajax({
    url: '/registrations/assign_supervisor',
    data: {role_id: roleId}
  });
});

$(document).on('change', '.income-client', function(){
  var clientId = $(this).val();
  $.ajax({
    url: '/finance_management/income_client',
    data: {client_id: clientId},
  });
});

$(document).on("focus", ".financial_date", function(){
  $(this).datepicker( {
      endDate: '-0d',
      format: "yyyy-mm-dd",
      autoclose: true
  });
});

$(document).ready(function(){
  $(".from_date").datepicker({
      endDate: '-0d',
      format: 'dd-mm-yyyy',
      autoclose: true,
  }).on('changeDate', function (selected) {
      var startDate = new Date(selected.date.valueOf());
      $('.to_date').datepicker('setStartDate', startDate);
  }).on('clearDate', function (selected) {
      $('.to_date').datepicker('setStartDate', null);
  });

  $(".to_date").datepicker({
     format: 'yyyy-mm-dd',
     endDate: '-0d',
     autoclose: true,
  }).on('changeDate', function (selected) {
     var endDate = new Date(selected.date.valueOf());
     $('.from_date').datepicker('setEndDate', endDate);
  }).on('clearDate', function (selected) {
     $('.from_date').datepicker('setEndDate', null);
  });
});