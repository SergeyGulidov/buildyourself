# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ($) ->
  $("a[rel*=facebox]").facebox()



$("#close").click ->
  $("#flash").hide()

jQuery ->

	$("#f_type").select2()
	$("#city").select2()
	$("#category").select2()
	$("#interval").select2()
	$("#place_type_ids").select2()
	$("#place_country_id").select2()
	$("#place_city_id").select2()
	$("#place_category_ids").select2()
	$("#place_interval_ids").select2()


	types = $('#f_type').html()
	$('#category').change ->
		category = $('#category :selected').text()
		options = $(types).filter("optgroup[label='#{category}']").html()
		if options
			$('#f_type').html(options)
		else
			$('#f_type').empty()




	types_for_new = $('#place_type_ids').html()
	$('#place_category_ids').change ->
		place_category_ids = $('#place_category_ids :selected').text()
		options = $(types_for_new).filter("optgroup[label='#{place_category_ids}']").html()
		if options
			$('#place_type_ids').html(options)
		else
			$('#place_type_ids').empty()




