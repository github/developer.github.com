$(function() {
  var searchIndex,
      searchHits,
      searchWorker = new Worker("/assets/javascripts/search_worker.js");

  $('.help-search .search-box').focus(function(){
    $(this).css('background-position','0px -25px')
  });

  $('.help-search .search-box').focusout(function(){
    if($(this).val() == ''){
      $(this).css('background-position','0px 0px')
    }
  });

  // Load the JSON containing all pages
  // Has it been loaded before (and stored with localstorage)?
  if (localStorage['searchIndex']) {
    searchIndex = JSON.parse(localStorage['searchIndex']);

    if (localStorageHasExpired()) {
      loadSearchIndex();
    }
    else {
      searchIndex.type = "index";
      searchWorker.postMessage(searchIndex);
    }
  } else {
    loadSearchIndex();
  }

  function loadSearchIndex() {
    $.getJSON('/search/search-index.json', function(data) {
      data.type = { index: true };
      searchWorker.postMessage(data);
      searchIndex = data;
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
    searchWorker.postMessage({ query: searchString, type: "search" })
  }

  searchWorker.addEventListener("message", function (e) {
    if (e.data.type.search) {
      renderResultsForSearch(e.data.query, e.data.results);
    }
  });

  // Update the UI representation of the search hits
  function renderResultsForSearch(searchString, searchHits){
    $("#search-results").empty();

    // Check if there are any results. If not, show placeholder and exit
    if (searchHits.length < 1) {
      $('<li class="placeholder">No results for <em></em></li>').appendTo("#search-results").find("em").text(searchString);
      return;
    }

    // Render results (max 8)
    for (var i = 0; i < Math.min(searchHits.length, 8); i++) {
      var page = searchHits[i];

      $('<li class="result"><a href="' + page.url + '"><em>' + page.title + '</em></a></li>').appendTo("#search-results");
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
});
