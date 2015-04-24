jQuery.ajaxSetup({
  'beforeSend': function(xhr) { xhr.setRequestHeader("Accept", "text/javascript") }
});

$.fn.subSelectWithAjax = function() {
  var that = this;
  this.change(function() {

    if (that.val() != 'Other' && that.val() != '' )
      $.get(that.attr('rel'), {id: that.val()}, null, "script");

    $('#'+that.attr('id')).hide_show_field();
  });
}

$.fn.specialSubSelectWithAjax = function() {
  var that = this;
  this.change(function() {
    
    if (that.val() != 'Other' && that.val() != '' )
      $.get(that.attr('rel'), { id: that.val(),company_id:$("#review_company_id").val() }, null, "script");

	   $('#'+that.attr('id')).hide_show_field();

  });
}

$.fn.hide_show_field = function() {
  var that = this;
  this.change(function() {
    var txt_id ="#txt_" + that.attr('id');

     if ('Other - please specify' == that.val()){
       $(txt_id).show();
		 }
		  else{
        $(txt_id).hide();
		  }
  });
}

$(document).ready(function(){
	$('.scroll-pane').jScrollPane();
  $("#txt_review_industry_id").hide();
  $("#txt_review_company_id").hide();
  $("#txt_review_town_id").hide();
  $("#txt_review_location_id").hide();

  $("#review_industry_id").subSelectWithAjax();
  $("#review_company_id").subSelectWithAjax();
  $("#review_town_id").specialSubSelectWithAjax();
  $("#review_location_id").hide_show_field();
  $("#review_town_id").hide_show_field();
  $("#review_company_id").hide_show_field();
  
});
