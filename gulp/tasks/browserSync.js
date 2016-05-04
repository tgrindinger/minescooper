var browserSync = require('browser-sync');
var gulp        = require('gulp');

gulp.task('browserSync', ['build'], function() {
	browserSync.init(['./build/**'], {
		server: {
			baseDir: './build'
		},
                port: process.env.PORT || 3000
	});
});
