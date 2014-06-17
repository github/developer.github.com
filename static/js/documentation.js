// Init sidebar
$(function() {
  var activeItem,
      helpList = $('#js-sidebar .js-topic'),
      firstOccurance = true,
      styleTOC = function() {
        var pathRegEx = /\/\/[^\/]+(\/.+)/g,
            docUrl = pathRegEx.exec(window.location.toString())
        if (docUrl){
          $('#js-sidebar .js-topic a').each(function(){
            if ($(this).parent('li').hasClass('disable'))
              $(this).parent('li').removeClass('disable')

            var url = $(this).attr('href').toString()
            var cleanDocUrl = docUrl[1]
            if(url.indexOf(cleanDocUrl) >= 0 && url.length == cleanDocUrl.length){
              $(this).parent('li').addClass('disable')
              var parentTopic = $(this).parentsUntil('div.sidebar-module > ul').last()
              parentTopic.addClass('js-current')
              parentTopic.find('.js-expand-btn').toggleClass('collapsed expanded')
            }
          });
        }
      }

  // bind every href with a hash; take a look at v3/search/ for example
  $('#js-sidebar .js-accordion-list .js-topic a[href*=#]').bind("click", function(e) {
    if (window.location.toString().indexOf($(e.target).attr('href')) == -1)
      setTimeout(styleTOC, 0); // trigger the window.location change, then stylize
  });

  // hide list items at startup
  if($('body.api') && window.location){
    styleTOC();
  }

  $('#js-sidebar .js-topic').each(function(){
    if(($(this).find('.disable').length == 0 || firstOccurance == false) &&
    $(this).hasClass('js-current') != true){
      $(this).find('.js-guides').children().hide()
    } else {
      activeItem = $(this).index()
      firstOccurance = false
    }
  })

  // Toggle style list. Expanded items stay
  // expanded when new items are clicked.
  $('#js-sidebar .js-toggle-list .js-expand-btn').click(function(){
    var clickedTopic = $(this).parents('.js-topic'),
        topicGuides  = clickedTopic.find('.js-guides li')
    $(this).toggleClass('collapsed expanded')
    topicGuides.slideToggle(100)
    return false
  })

  // Accordion style list. Expanded items
  // collapse when new items are clicked.
  $('#js-sidebar .js-accordion-list .js-topic h3 a').click(function(){
    var clickedTopic = $(this).parents('.js-topic'),
        topicGuides = clickedTopic.find('.js-guides li')

    if(activeItem != clickedTopic.index()){
      if(helpList.eq(activeItem)){
        helpList.eq(activeItem).find('.js-guides li').slideToggle(100)
      }
      activeItem = clickedTopic.index()
      topicGuides.slideToggle(100)
    } else {
      activeItem = undefined
      topicGuides.slideToggle(100)
    }

    return false
  })

  $('.help-search .search-box').focus(function(){
    $(this).css('background-position','0px -25px')
  })

  $('.help-search .search-box').focusout(function(){
    if($(this).val() == ''){
      $(this).css('background-position','0px 0px')
    }
  })

  // Dynamic year for footer copyright
  var currentYear = (new Date).getFullYear();
  $("#year").text( (new Date).getFullYear() );

  // Grab API status
  $.getJSON('https://status.github.com/api/status.json?callback=?', function(data) {
    if(data) {
      var link = $("<a>")
        .attr("href", "https://status.github.com")
        .addClass(data.status)
        .attr("title", "API Status: " + data.status + ". Click for details.")
        .text("API Status: " + data.status);
      $('.api-status').html(link);
    }
  });

  // Add link anchors for headers with IDs
  $(".content h1, .content h2, .content h3, .content h4").each(function(e){
    var id = $(this).attr("id");
    if (!id) return;

    $(this).prepend("<a class='header-anchor' href='#" + id + "'></a>");
  });

  // #### Search ####
  var searchIndex,
      searchHits;

  // Load the JSON containing all pages
  // Has it been loaded before (and stored with localstorage)?
  if (localStorage['searchIndex']) {
    searchIndex = JSON.parse(localStorage['searchIndex']);

    if (localStorageHasExpired())
      loadSearchIndex();
  } else {
    loadSearchIndex();
  }

  function loadSearchIndex() {
    $.getJSON('/search-index.json', function(data) {
      searchIndex = data["pages"];
      localStorage['searchIndex'] = JSON.stringify(searchIndex);
      localStorage['updated'] = new Date().getTime();
    });
  }

  function localStorageHasExpired() {
    // Expires in one day (86400000 ms)
    if (new Date().getTime() - parseInt(localStorage['updated'],10) > 86400000) {
      return true;
    }

    return false;
  }

  // Expand and activate search if the page loaded with a value set for the search field
  if ($("#searchfield").val().length > 0) {
    $("#search-container").addClass("active");
    searchForString($("#searchfield").val());
  }

  // On input change, update the search results
  $("#searchfield").on("input", function(e) {
    $(this).val().length > 0 ? $("#search-container").addClass("active") : $("#search-container").removeClass("active");

    searchForString($(this).val());
  });

  // Global keyboard shortcuts
  $("body").keyup(function(e) {
    if (e.keyCode == 83) {
      // S key
      if ($("#searchfield").is(":focus"))
        return;

      e.preventDefault();
      $("#searchfield").focus();
    }
  });

  // Keyboard support for the search field
  $("#searchfield").keyup(function(e) {
    if (e.keyCode == 27) {
      // ESC
      e.preventDefault();
      $("#searchfield").val().length > 0 ? cancelSearch() : $("#searchfield").blur();
    } else if (e.keyCode == 13) {
      // Return/enter
      e.preventDefault();
      goToSelectedSearchResult();
    }  else if (e.keyCode == 8 || e.keyCode == 46) {
      // Update search if backspace/delete was pressed
      // IE9 doesn't trigger the input event on backspace/delete,
      // but they do trigger keyUp
      $(this).val().length > 0 ? $("#search-container").addClass("active") : $("#search-container").removeClass("active");

      searchForString($(this).val());
    }
  }).keydown(function(e) {
    if (e.keyCode == 38) {
      // Arrow up
      e.preventDefault();
      moveSearchSelectionUp();
    } else if (e.keyCode == 40) {
      // Arrow down
      e.preventDefault();
      moveSearchSelectionDown();
    } else if (e.keyCode == 27) {
      // Prevent default on ESC key
      // IE inputs come with some native behaviors that will
      // prevent the DOM from updating correctly unless prevented
      e.preventDefault();
    }
  });

  // Make clicking the label focus the input label
  // for browsers (IE) that doesn't support pointer-events: none
  $("#search-container .search-placeholder").click(function(e) {
    $("#searchfield").focus();
  });

  $(".cancel-search").click(function(e) {
    cancelSearch();
  });

  function cancelSearch() {
    $("#searchfield").val("");
    $("#search-container").removeClass("active");
  }

  function searchForString(searchString) {
    searchHits = [];
    searchString = searchString.toLowerCase();

    // Search for string in all pages
    for (var i = 0; i < searchIndex.length; i++) {
      var page = searchIndex[i];

      // Add the page to the array of hits if there's a match
      if (page.title.toLowerCase().indexOf(searchString) !== -1) {
        searchHits.push(page);
      }
    }

    renderResultsForSearch(searchString);
  }

  // Update the UI representation of the search hits
  function renderResultsForSearch(searchString){
    $("#search-results").empty();

    // Check if there are any results. If not, show placeholder and exit
    if (searchHits.length < 1) {
      $('<li class="placeholder">No results for <em></em></li>').appendTo("#search-results").find("em").text(searchString);
      return;
    }

    // Render results (max 8)
    for (var i = 0; i < Math.min(searchHits.length, 8); i++) {
      var page = searchHits[i];

      $('<li class="result"><a href="' + page.url + '"><em>' + page.title + '</em><small>' + page.section + '</small></a></li>').appendTo("#search-results");
    }

    // Select the first alternative
    $("#search-results li:first-child").addClass("selected");
  }

  // Move the selected list item when hovering
  $("#search-results").on("mouseenter", "li", function(e) {
    $(this).parent().find(".selected").removeClass("selected").end().end()
      .addClass("selected");
  });

  function moveSearchSelectionUp() {
    $prev = $("#search-results .selected").prev();
    if ($prev.length < 1)
      return;

    $("#search-results .selected").removeClass("selected");
    $prev.addClass("selected");
  }

  function moveSearchSelectionDown() {
    $next = $("#search-results .selected").next();
    if ($next.length < 1)
      return;

    $("#search-results .selected").removeClass("selected");
    $next.addClass("selected");
  }

  function goToSelectedSearchResult() {
    var href = $("#search-results .selected a").attr("href");
    if (href)
      window.location.href = href;
  }

  // Earth animation
  if ($('.dev-program').length) {
    setTimeout(function() {
      $('.earth').fadeOut();
      $('.earth-short-loop').show();
    }, 19 * 1000); // Let first loop run through 19 seconds
  }

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
