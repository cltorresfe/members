$(document).ready ->

  $('#attendance_date').datetimepicker
    format: 'DD/MM/YYYY'

  $('#ministry_id').on 'change', ()->
    $('#attendance-index-form').submit()

  $('#attendance_date').on 'dp.change', ()->
    $('#attendance-index-form').submit()
