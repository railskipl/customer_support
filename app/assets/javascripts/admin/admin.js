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
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap 
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require admin/addresses.js.coffee
//= require jquery_nested_form

$(document).ready(function() {
 	  $('#polls').dataTable();
 	  $('#index_agents').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [3] }] });
 	  $('#recently_added_review').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [6] }] });
 	  $('#published_review').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [6] }] });
    $('#archived_review').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [6] }] });
    $('#admin_review').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [6] }] });
    // $('#review_notes').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [1] }] });
    $('#customers').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [4] }] });
    $('#nature_of_reviews').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [2] }] } );
	  $('#industries').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [1]}] } );
	  $('#companies').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [2] }] } );
	  $('#locations').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [2] }] } );
	  $('#towns').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [1] }] } );
	  $('#addresses').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [3] }] } );
	  $('#reviews').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [6] }] });
	  $('#reviews1').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [5] }] });
    $('#reviews2').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [5] }] });
    $('#reviews3').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [] }] });
    $('#notification').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [4] }] });
    $('#allnotification').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [4] }] });
    $('#monitor').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [5] }] });
    $('#monitor2').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [5] }] });
	  $('#faqs').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [2] }] } );
 	  $('#pages').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [3] }] } );
		$('#resources').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [3] }] } );
		$('#resource_types').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [1] }] } );
		$('#agents').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [4] }] } );
		$('#suppliers').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [8] }] } );
		$('#advertises').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [4] }] } );

		$('#seos').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [3] }] } );
       $('#company_performances').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [5] }] } );
       $('#supplier_registration').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [] }] } );
       $('#abuse_report').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [2] }] } );
       $('#arfiles').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [] }] } );
       $('#admin_review_xls').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [5] }] });
       $('#active_customer').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [3] }] });
       $('#total_customer_reviews').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [1] }] });
       $('#total_compliment').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [1] }] });
       $('#complaints').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [1] }] } );
       $('#compliments').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [1] }] } );
       $('#industry_xls').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [1] }] } );
       $('#most_complaints').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [1] }] } );
       $('#supplierprofile').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [1] }] } );
       $('#company_supplier').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [1] }] } );
       $('#registered_supplier').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [4] }] } );
       $('#unregistered_supplier').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [4] }] } );
       $('#supplier_level').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [1] }] } );
       $('#supplier_level_compliment').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [1] }] } );
       $('#supplier_level_complaint').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [1] }] } );
       $('#industry_conversion').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [2] }] } );
       $('#poll_id').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [4] }] } );
       $('#reviews_processed').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [4] }] } );
       $('#agent_output').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [8] }] } );
       $('#agent_performance').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [6] }] } );
});
