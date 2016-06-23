$(document).ready(function() {

  $('#wizard').smartWizard({
    // Default Properties and Events
    transitionEffect: 'slide',
    labelNext: 'Siguiente',
    labelPrevious: 'Anterior',
    labelFinish: 'Guardar',
    ajaxType: "POST",
    onFinish: null  // triggers when Finish button is clicked
  });

  $('.buttonNext').addClass('btn btn-success');
  $('.buttonPrevious').addClass('btn btn-primary');
  $('.buttonFinish').addClass('btn btn-default');
  $('.buttonFinish').click(function () {
    $.submit();
  });
});

