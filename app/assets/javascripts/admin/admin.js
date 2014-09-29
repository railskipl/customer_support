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
    $('#customers').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [4] }] });
    $('#nature_of_reviews').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [2] }] } );
	  $('#industries').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [1]}] } );
	  $('#companies').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [3] }] } );
	  $('#locations').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [2] }] } );
	  $('#towns').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [1] }] } );
	  $('#addresses').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [3] }] } );
	  $('#reviews').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [6] }] });
	  $('#faqs').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [2] }] } );
 	  $('#pages').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [3] }] } );
		$('#resources').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [3] }] } );
		$('#resource_types').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [1] }] } );
		$('#agents').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [4] }] } );
		$('#suppliers').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [8] }] } );
		$('#advertises').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [4] }] } );

		$('#seos').dataTable({"aoColumnDefs": [ { 'bSortable': false, 'aTargets': [3] }] } );

});
