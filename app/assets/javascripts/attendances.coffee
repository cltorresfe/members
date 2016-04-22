$(document).ready ->

  $('#ministry_id').on 'change', ()->
    $('#attendance-form').submit()
