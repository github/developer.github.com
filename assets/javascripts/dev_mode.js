// Init sidebar
$(function() {
  $(window).keydown(function(e){
    // d
    if (e.keyCode == 68) {
      $("body.dev-mode").toggleClass('enterprise')
    }
  });
});
