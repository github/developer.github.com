importScripts('lunr.min.js');

// create lunr.js search index specifying that we want to index the title and body fields of documents.
var lunr_index = lunr(function() {
      this.field('title', { boost: 10 });
      this.field('body');
      this.ref('id');
    }),
    entries;

onmessage = function (oEvent) {

  populateIndex = function(data) {
    // format the raw json into a form that is simpler to work with
    this.entries = data.map(this.createEntry).filter(function(n){ return n !== undefined });
    this.entries.forEach(function(entry) {
      if (entry !== null)
        this.lunr_index.add(entry);
    });

    postMessage({type: {indexed: true}});
  };

  decodeHtmlEntity = function(str) {
    return str.replace(/&#(\d+);/g, function(match, dec) {
      return String.fromCharCode(dec);
    });
  };

  createEntry = function(entry, entry_id) {
    if (entry.title === undefined)
      return undefined;
    entry.id = entry_id + 1;
    entry.title = decodeHtmlEntity(entry.title);
    return entry;
  };

  search = function(data) {
    var entries = this.entries;

    var results = lunr_index
                  .search(data.query)
                  .map(function(result) {
                    return entries.filter(function(entry) { return entry.id === parseInt(result.ref, 10); })[0];
                  })
                  .filter(function (result) {
                      return typeof result !== 'undefined';
                  });

    postMessage({ query: data.query, results: results, type: { search: true } });
  }

  // if we're asked to index, index! else, search
  if (oEvent.data.type == "index")
    populateIndex(oEvent.data);
  else
    search(oEvent.data);
};
