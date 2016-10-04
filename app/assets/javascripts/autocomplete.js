$autocompleteItems = $('<ul id="autocomplete-items" class=""></ul>');

var Autocomplete = {
  setup: function() {    
    $("#search_q").keydown(function() {
      Autocomplete.getData($("#search_q").val());
    });
  },

  getData: function(term) {
    $.ajax({
      url: '/autocomplete.json?term=' + term,
      dataType: "JSON",
      method: "GET",
      success: Autocomplete.render
    });
  },

  render: function(data) {
    console.log(data);
    var imageTag;
    var items = $.map(data, function(member) {
      imageTag = '<img width="35" class="avatar-image" src="' + member.avatar_url + '"/>';
      return '<li><a href="' + member.url + '">' + imageTag + member.first_name + '</a></li>';
    });

    if (items.length > 0) {
      $autocompleteItems.html(items.join(' '));
      $('#main-searchbar').after($autocompleteItems);
      $autocompleteItems.show();
      console.log('fired');
    } else {
      $('#autocomplete-items').html('');
      $autocompleteItems.hide();
    }
  }
};

$(document).ready(Autocomplete.setup);
$(document).on('page:load', Autocomplete.setup);