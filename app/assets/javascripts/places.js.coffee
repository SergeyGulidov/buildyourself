# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$("#close").click ->
  $("#flash").hide()

jQuery ->

	$("#f_type").select2()
	$("#city").select2()
	$("#category").select2()
	$("#place_type_id").select2()
	$("#place_country_id").select2()
	$("#place_city_id").select2()
	$("#place_category_id").select2()


	types = $('#f_type').html()
	$('#category').change ->
		category = $('#category :selected').text()
		options = $(types).filter("optgroup[label='#{category}']").html()
		if options
			$('#f_type').html(options)
		else
			$('#f_type').empty()

	types_for_new = $('#place_type_id').html()
	$('#place_category_id').change ->
		place_category_id = $('#place_category_id :selected').text()
		options = $(types_for_new).filter("optgroup[label='#{place_category_id}']").html()
		if options
			$('#place_type_id').html(options)
		else
			$('#place_type_id').empty()


$("#feed_message").keyup ->
  max = 255
  len = $(this).val().length
  if len >= max
    $("#charNum").text " 0 "
  else
    char = max - len
    $("#charNum").text char 
