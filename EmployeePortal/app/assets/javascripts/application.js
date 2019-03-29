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
//= require app
//= require jquery_ujs
//= require bootstrap-datepicker
//= require jquery.timepicker.js
//= require jquery.remotipart
//= require jquery.numeric
//= require_tree .

$(document).on("focus", ".datepicker", function(){
	$(this).datepicker({
		todayHighlight:'TRUE',
		startDate: '-0d',
		endDate: '+2m',
		format: 'dd-mm-yyyy',
		autoclose: true
	});
});

$( function() {
	$('.timepicker').timepicker({ 'scrollDefault': 'now' });
	$(".full_calendar").datepicker({format: 'dd-mm-yyyy'});
});

$(document).on("focus", ".pro_from_date", function(){
  $(this).datepicker({
    startView: "decade",
    startDate: '-50y',
    endDate: '-1y',
    format: 'yyyy-mm-dd',
    autoclose: true
  });
});

$(document).on("focus", ".pro_to_date", function(){
  $(this).datepicker({
    startView: "decade",
    startDate: '-50y',
    endDate: '-1y',
    format: 'yyyy-mm-dd',
    autoclose: true
  });
});

$(document).on("click",".edit_comment", function(){
	var index = $(this).data("index");
	var task = $(this).data("task");
	$("#edit_task_"+task+ " "+ "#task_task_comments_attributes_"+index+"_description").removeClass('secure_input');
});

$(document).on("focus", ".future_datepicker", function(){
	$(this).datepicker({
		todayHighlight:'TRUE',
		endDate: '+0d',
		format: 'dd-mm-yyyy',
		autoclose: true
	});
});


$(document).on("change", ".time_sheet_entry", function(){
	var task = $(this).val();
	var day = $(this).data("day");
	$.ajax({
		url: "/check_task",
		data: {task_id: task, day: day},
		dataType: "script"
	})
});