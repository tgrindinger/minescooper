var browserify   = require('browserify');
var watchify     = require('watchify');
var bundleLogger = require('../util/bundleLogger');
var gulp         = require('gulp');
var handleErrors = require('../util/handleErrors');
var source       = require('vinyl-source-stream');

gulp.task('browserify', function() {
	var bundleMethod = global.isWatching ? watchify : browserify;

        var props = {
		entries: ['./source/javascripts/minegame.coffee'],
		extensions: ['.coffee'],
                debug: true,
                cache: {},
                packageCache: {}
        };
        var bundler = global.isWatching ? watchify(browserify(props)) : browserify(props);

	var bundle = function() {
		bundleLogger.start();
                var stream = bundler.bundle();
                return stream.on('error', handleErrors)
			.pipe(source('compiled.js'))
			.pipe(gulp.dest('./build'))
			.on('end', bundleLogger.end);
	};

	if (global.isWatching) {
		bundler.on('update', bundle);
	}

	return bundle();
});
