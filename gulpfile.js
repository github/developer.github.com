var gulp   = require("gulp"),
    gulpif = require("gulp-if"),
    sass   = require("gulp-sass"),
    minifyCss = require("gulp-minify-css"),
    replace = require("gulp-replace"),
    coffee = require("gulp-coffee"),
    concat = require("gulp-concat"),
    uglify = require("gulp-uglify"),
    yaml   = require("js-yaml"),

    exec = require('child_process').exec,

    fs   = require('fs'),
    path = require("path");

CONFIG = yaml.safeLoad(fs.readFileSync("nanoc.yaml", "utf8"));
IS_PRODUCTION = process.env.NODE_ENV == "production";

var transformCS = function (file) {
  return path.extname(file.path) == ".coffee";
};

gulp.task("css", function() {
  return gulp.src([
    "assets/stylesheets/reset.css",
    "assets/stylesheets/documentation.css",
    "assets/stylesheets/pagination.css",
    "assets/stylesheets/pygments.css",
    "assets/vendor/octicons/octicons/octicons.css"
    ])
    .pipe(concat("application.css"))
    .pipe(gulpif(IS_PRODUCTION, minifyCss()))
    .pipe(gulp.dest("output/assets/stylesheets/"));
});

gulp.task("javascript", function () {
  gulp.src("assets/javascripts/dev_mode.js")
    .pipe(gulp.dest("output/assets/javascripts/"));
  return gulp.src([
    "assets/javascripts/documentation.js",
    "assets/javascripts/search.js",
    "assets/javascripts/images.js",
    "assets/vendor/retinajs/src/retinajs"
    ])
    .pipe(gulpif(transformCS, coffee()))
    .pipe(concat("application.js"))
    .pipe(gulpif(IS_PRODUCTION, uglify()))
    .pipe(gulp.dest("output/assets/javascripts"));
});

gulp.task("javascript_workers", function () {
  return gulp.src([
    "assets/javascripts/search_worker.js",
    "assets/vendor/lunr.js/lunr.min.js"
    ])
    .pipe(gulp.dest("output/assets/javascripts"));
});

gulp.task("octicons", function() {
  return gulp.src("assets/vendor/octicons/octicons/**/*")
    .pipe(gulp.dest("output/assets/stylesheets"));
});

gulp.task("images", function() {
  return gulp.src("assets/images/**/*")
    .pipe(gulp.dest("output/assets/images"));
});

gulp.task("nanoc:compile", function (cb) {
  exec("bundle exec nanoc compile", {maxBuffer: 1024 * 1000}, function (err, stdout, stderr) {
    console.log(stdout);
    console.log(stderr);
    cb(err);
  });
});

gulp.task("server", function() {
  connect = require("gulp-connect");
  connect.server({
    port: 4000,
    root: ["output"]
  });
});

gulp.task("watch:nanoc", function() {
  gulp.watch([
    "nanoc.yaml",
    "Rules",
    "content/**/*",
    "layouts/**/*",
    "lib/**/*"
  ], ["nanoc:compile"]);
});

gulp.task("watch:assets", function() {
  gulp.watch([
    "assets/**/*"
  ], ["assets"]);
});

gulp.task("serve", [ "server", "watch:nanoc", "watch:assets" ]);
gulp.task("assets", [ "css", "javascript", "javascript_workers", "octicons", "images" ]);
gulp.task("build", [ "nanoc:compile", "assets" ]);
gulp.task("default", [ "build", "serve" ]);
