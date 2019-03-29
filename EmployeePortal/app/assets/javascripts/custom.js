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

$(document).on('change', '#employee_role_id', function(){
  var roleId = $(this).val();
  $.ajax({
    url: '/registrations/assign_supervisor',
    data: {role_id: roleId}
  });
});
$(document).on('keyup','.filterrific-periodically-observed', function(){
  var data = $(this).closest("form").submit();
});


$(document).on('keypress', "#employee_emergency_contact_detail_contact_number", function(){
  if (!event.charCode) return true;          
  ch = String.fromCharCode(event.charCode);
  return (/[\d]/.test(ch));
});

$(document).on('change', ".assign-select-client", function(){
  var client = $(this).val();
  if (client){ 
    $.ajax({
      url: '/change_client',
      data: {client_id: client}
    });
  }
});

$(document).on('change', '.assign-select-project', function(){
  var project = $(this).val();
  if (project){
    $.ajax({
      url: '/project_employees',
      data: {project_id: project}
    });
  } 
});

$(document).on('click', '.unassign-btn', function(){
   if ($('input[name="project_employee_unassign[]"]:checked').length > 0) {
    return true
  }
  else {
    alert("Please select at least one employee.");
    return false
  }
});

$(document).on('click', '.assign-btn', function(){
  if ($('input[name="project_employee_assign[]"]:checked').length > 0) {
    return true
  }
  else {
    alert("Please select at least one employee.");
    return false
  }
});
$(document).on('click', '.qualification-btn', function(){
  var thisValue = $("#employee_qualification_detail_percentage").val();
  if (validate(thisValue) == false){
    alert("Enter Correct format for percentage. EX: 90.5, 89")
    return false;
  }
});

function validate(x) {
  var parts = x.split(".");
  if (typeof parts[1] == "string" && (parts[1].length == 0 || parts[1].length > 2))
      return false;
  var n = parseFloat(x);
  if (isNaN(n))
      return false;
  if (n < 0 || n > 100)
      return false;
  
  return true;
}