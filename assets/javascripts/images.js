$(function() {
  // copy Help's image show/hide functionality in OLs
  var dismissFullImage;

  $('ol img').each(function(index, elem) {
    return $(elem).parent().prepend(elem);
  });

  $(document).on('click', 'ol img', function(event) {
    var $fullImg, $img;
    dismissFullImage();
    $img = $(event.currentTarget).clone();
    $fullImg = $('<div class="js-full-image full-image"><span class="octicon octicon-remove-close"></span></div>').prepend($img);
    $(this).closest('li').append($fullImg);
    return $(document).on('click', '.js-full-image', function() {
      dismissFullImage();
      return false;
    });
  });

  dismissFullImage = function() {
    $(document).off('click', '.js-full-image', dismissFullImage);
    return $('.js-full-image').remove();
  };
});
