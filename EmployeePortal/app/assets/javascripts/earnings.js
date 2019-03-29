$(document).on('click', '.btn-definition', function(){
  var d = new Date();
  current_date = d.getDate()
  if (current_date > 15) {
    console.log("sfsdfsd")
    return false;
  }
  
  houseAmount = $('.house-rent').data('amount');
  houseEnteredAmt = $('.house-rent').val();
  if (houseEnteredAmt > houseAmount) {
    $('.rent-error').html("Please Enter 50% of Basic PM");
    return false;
  }
  medicalAmount = $('.medical-amt').data('amount');
  medicalEnteredAmt = $('.medical-amt').val();
  if (medicalEnteredAmt > medicalAmount) {
    $('.medical-error').html("Maximum 1250/- PM");
    return false;
  }
  telephoneAmount = $('.telephone-amt').data('amount');
  telephoneEnteredAmt = $('.telephone-amt').val();
  if (telephoneEnteredAmt > telephoneAmount) {
    $('.telephone-error').html('Maximum 500/- PM');
    return false;
  }
  console.log("rrrrrrrrrrr");
});

$(document).on('focusout', '.house-rent', function(){
  houseAmount = $(this).data('amount');
  houseEnteredAmt = $(this).val();
  if (houseEnteredAmt > houseAmount) {
    $('.rent-error').html("Please Enter 50% of Basic PM");
    $('.rent-error').css('display', 'block');
    return false;
  }
  else {
    $('.yearly-house-rent').text(houseEnteredAmt * 12);
    console.log($('.yearly-house-rent').text());
    $('.rent-error').css('display', 'none');
    $('.rent-error').html("");
  }
});

$(document).on('focusout', '.medical-amt', function(){
  houseAmount = $(this).data('amount');
  houseEnteredAmt = $(this).val();
  if (houseEnteredAmt > houseAmount) {
    $('.medical-error').html("Maximum 1250/- PM");
    $('.medical-error').css('display', 'block');
    return false;
  }
  else {
    $('.yearly-medical').text(houseEnteredAmt * 12)
    $('.medical-error').css('display', 'none');
    $('.medical-error').html("");
  }
});
$(document).on('focusout', '.telephone-amt', function(){
  houseAmount = $(this).data('amount');
  houseEnteredAmt = $(this).val();
  if (houseEnteredAmt > houseAmount) {
    $('.telephone-error').html("Maximum 500/- PM");
    $('.telephone-error').css('display', 'block');
    return false;
  }
  else {
    $('.yearly-telephone').text(houseEnteredAmt * 12)
    $('.telephone-error').css('display', 'none');
    $('.telephone-error').html("");
  }
});