# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#address_location_id').parent().hide()
  locations = $('#address_location_id').html()
  $('#address_town_id').change ->
    town = $('#address_town_id :selected').text()
    escaped_town = town.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(locations).filter("optgroup[label='#{escaped_town}']").html()
    if options
      $('#address_location_id').html(options)
      $('#address_location_id').parent().show()
    else
      $('#address_location_id').empty()
      $('#address_location_id').parent().hide()
