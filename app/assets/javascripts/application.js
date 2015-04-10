// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.datepicker
//= require jquery.modal
//= require bootstrap-transition
//= require bootstrap-dropdown
//= require bootstrap-collapse
//= require jquery.jscrollpane.min
//= require reviews
//= require ckeditor/init
//= require ckeditor/override
//= require highcharts
//= require highcharts/highcharts-more
//= require highcharts/modules/exporting


 $(document).ready(function(ev){
      $('#datepicker1').datepicker({dateFormat: 'dd-mm-yy'});
      $('#datepicker2').datepicker({dateFormat: 'dd-mm-yy'});
      $('#datepicker3').datepicker({dateFormat: 'dd-mm-yy'});
      $('#datepicker4').datepicker({dateFormat: 'dd-mm-yy'});

      if ($("#review_is_modified").is(":checked"))
	     	$("#agent_modified_review").show();
      else
 	     	$("#agent_modified_review").hide();
	    

      $("#review_is_modified").click(function(){
	      if ($("#review_is_modified").is(":checked"))
	      	$("#agent_modified_review").show();
	      else
	      	$("#agent_modified_review").hide();
      });
 });
 
