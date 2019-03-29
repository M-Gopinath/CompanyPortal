
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
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-datepicker
//= require jquery.timepicker.js
//= require jquery.remotipart
//= require_tree .

$(document).ready(function(){
	$('.datepicker').datepicker({
		todayHighlight:'TRUE',
	    startDate: '-0d',
	    endDate: '+2m',
	    format: 'yyyy-mm-dd',
	    autoclose: true
	});

	$(".from_date").datepicker({
	  	startDate: '-0d',
	    endDate: '+2m',
	    format: 'yyyy-mm-dd',
	    autoclose: true,
	}).on('changeDate', function (selected) {
	    var startDate = new Date(selected.date.valueOf());
	    $('.to_date').datepicker('setStartDate', startDate);
	}).on('clearDate', function (selected) {
	    $('.to_date').datepicker('setStartDate', null);
	});

	$(".to_date").datepicker({
	   format: 'yyyy-mm-dd',
	   autoclose: true,
	}).on('changeDate', function (selected) {
	   var endDate = new Date(selected.date.valueOf());
	   $('.from_date').datepicker('setEndDate', endDate);
	}).on('clearDate', function (selected) {
	   $('.from_date').datepicker('setEndDate', null);
	});

	$( function() {
  	$('.timepicker').timepicker({ 
  		
  	 });
	});

});

$(document).on("click",".edit_comment", function(){
	var index = $(this).data("index");
	var task = $(this).data("task");
	$("#edit_task_"+task+ " "+ "#task_task_comments_attributes_"+index+"_description").removeClass('secure_input');
});

$(document).on('keyup','.filterrific-periodically-observed', function(){
  var data = $(this).closest("form").submit();
});

$(document).on('change', '#project_assign', function(){
  var projectId = $(this).val();
  $.ajax({
    url: '/feedbacks/project_employee',
    data: {project_id: projectId}
  });
});

function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : evt.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

