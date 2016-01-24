# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->
  $('[data-toggle="tooltip"]').tooltip({ container : 'body' })

  $('.chosen-select').chosen({ search_contains : true })

  $('input:checkbox#fan_checkbox').on 'change', ->
    $(this.form).submit()

  $('.btn-file :file').on 'fileselect', (event, numFiles, label) ->
    input = $(this).closest('.input-group').find('input:text')
    log = numFiles > 1 ? numFiles + ' files selected' : label
    if input.length
      input.attr('value', label)
    else if log
      alert(log)

  $('input:checkbox#remove_header, input:checkbox#band_active').bootstrapSwitch();
