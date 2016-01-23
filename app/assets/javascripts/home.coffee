# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->
  $('.search-box .dropdown-menu a').on 'click', ->
    data = $(this).attr('data-value')
    form = $('#search-form')
    form.attr('action', data)
    $(form).find('input#search').attr('placeholder', 'search in ' + data[1..data.length-1])

  $('#search-form').on 'submit', ->
    if !$(this).find('input#search').val()
      alert('Search input cannot be blank!')
      false

