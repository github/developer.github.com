'use strict';

var gulp = require('gulp');

gulp.run(function() {
  gulp.src('./test/scss/error.scss')
    .pipe(require('./index.js').sync())
    .on('error', function(err) {
      console.log(err.messageFormatted);
    })
})
