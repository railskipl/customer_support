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
      $.get(that.attr('rel'), { id: that.val(),company_id:$("#report_company_id").val() }, null, "script");

	   $('#'+that.attr('id')).hide_show_field();

  });
}

$.fn.hide_show_field = function() {
  var that = this;
  this.change(function() {
    var txt_id ="#txt_" + that.attr('id');

     if ('Other' == that.val()){
       $(txt_id).show();
		 }
		  else{
        $(txt_id).hide();
		  }
  });
}

$(document).ready(function(){
	$('.scroll-pane').jScrollPane();
  $("#txt_report_industry_id").hide();
  $("#txt_report_company_id").hide();
  $("#txt_report_town_id").hide();
  $("#txt_report_location_id").hide();

  $("#report_industry_id").subSelectWithAjax();
  $("#report_company_id").subSelectWithAjax();
  $("#report_town_id").specialSubSelectWithAjax();
  $("#report_location_id").hide_show_field();
  $("#report_town_id").hide_show_field();
  $("#report_company_id").hide_show_field();
  
});

