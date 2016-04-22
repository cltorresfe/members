$(document).ready ->

  $('#attendance_date').datetimepicker
    format: 'DD/MM/YYYY'

  $('#ministry_id').on 'change', ()->
    $('#attendance-form').submit()
