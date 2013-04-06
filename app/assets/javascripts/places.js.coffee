# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ($) ->
  $("a[rel*=facebox]").facebox()



$("#close").click ->
  $("#flash").hide()

jQuery ->

	$("#type_name").select2()
	$("#city").select2()
	$("#category").select2()
	$("#interval").select2()


	types = $('#type_name').html()

	$('#category').change ->
		category = $('#category :selected').text()
		console.log(category)
		options = $(types).filter("optgroup[label='#{category}']").html()
		console.log(options)
		if options
			$('#type_name').html(options)
		else
			$('#type_name').empty()








