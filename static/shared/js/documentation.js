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
  
  // # Search
  var searchIndex,
      searchHits;
  
  // Load the JSON containing all pages
  $.getJSON('/search-index.json', function(data) {
    searchIndex = data["pages"];    
  });
  
  // On input change, update the search results
  $("#search").bind("input", function(e) {
    $(this).val().length > 0 ? $("#search-container").addClass("active") : $("#search-container").removeClass("active");
    
    searchForString($(this).val());
  });
  
  // Press ESC to exit search
  $("#search").keydown(function(e) {
    if (e.keyCode == 27) exitSearch();
  });
  
  $(".cancel-search").click(function(e) {
    exitSearch();
  });
  
  function exitSearch() {
    $("#search-container").removeClass("active");
    $("#search").val("");
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
    
    updateResults();
  }
  
  // Update the UI representation of the search hits
  function updateResults(){
    $("#search-results").empty();
    
    // Check if there are any results. If not, show placeholder and exit
    // […]
    
    // Render results
    for (var i = 0; i < searchHits.length; i++) {
      var page = searchHits[i];
    
      $('<li class="result"><a href="' + page.url + '"><em>' + page.title + '</em><small>' + page.section + '</small></a></li>').appendTo("#search-results");
    }
  }

});
