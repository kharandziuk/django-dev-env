assert = require 'assert'
TEMPLATEROOT = 'assets/tmpl/'

module.exports = (grunt) ->
  require('time-grunt')(grunt)
  require('jit-grunt')(grunt)

  appConfig = grunt.file.readJSON('package.json')

  pathsConfig = (appName)->
    @app = appName || appConfig.name

    return {
      app: @app
      # assets
      coffee: 'assets/coffee'
      less: 'assets/less'
      temlatesSrc: TEMPLATEROOT
      testsSrc: 'assets/tests'
      imgSrc: 'assets/images'
      fontsSrc: 'assets/fonts'
      # static
      bower: 'static/components'
      js: 'static/js'
      imgDst: 'static/images'
      fontsDst: 'static/fonts'
      css: 'static/css'
      temlatesDst: 'static/js/tmpl'
      testsDst: 'static/js/tests'
    }

  grunt.initConfig({
    paths: pathsConfig(),
    pkg: appConfig,
    handlebars:
      compile:
        options:
          amd: true
          processName: (name)->
            return name.replace(TEMPLATEROOT, '')
          partialRegex: /^partial_/
          processPartialName: (path)->
            assert(path.match(/\.htm/g).length is 1)
            assert(path.match(/partial_/g).length is 1)
            return path
              .replace(TEMPLATEROOT, '')
              .replace('.htm', '')
              .replace('partial_', '')

        src: ['<%= paths.temlatesSrc %>/**/*.htm']
        dest: '<%= paths.temlatesDst %>/templates.js'
    watch:
      grunt:
        files: ['Gruntfile.coffee']
      coffee:
        files: ['<%= paths.coffee %>/**/*.coffee', '<%= paths.testsSrc %>/**/*.coffee']
        tasks: ['newer:coffee']
      less:
        files: ['<%= paths.less %>/**/*.less']
        tasks: ['less']
        options:
          nospawn: true
      copy:
        files: ['<%= paths.imgSrc %>/**', '<%= paths.fontsSrc %>/**',]
        tasks: ['copy']
        options:
          nospawn: true
      handlebars:
        files: ['<%= paths.temlatesSrc %>/**',]
        tasks: ['handlebars']
        options:
          nospawn: true
    karma:
      unit:
        configFile: 'karma.conf.coffee'
    bower:
      install:
        options:
          targetDir: '<%= paths.bower %>'
          layout: 'byComponent'
          #install: false
          verbose: false
          cleanTargetDir: true
          cleanBowerDir: false
          bowerOptions: {}
    less:
      development:
        options:
          paths: ['./assets/less'],
        files:
          {
            '<%= paths.css %>/app.css': '<%= paths.less %>/app.less',
            '<%= paths.css %>/base.css': '<%= paths.less %>/base.less'
          }
    copy:
      templates:
        expand: true
        cwd: '<%= paths.temlatesSrc %>'
        src: ['**']
        dest: '<%= paths.temlatesDst %>'
      images:
        expand: true
        cwd: '<%= paths.imgSrc %>'
        src: ['**']
        dest: '<%= paths.imgDst %>'
      fonts:
        expand: true
        cwd: '<%= paths.fontsSrc %>'
        src: ['**']
        dest: '<%= paths.fontsDst %>'
    coffee: {
      frontend:
        options:
          bare: true
        expand: true
        flatten: false
        cwd: '<%= paths.coffee %>'
        src: ['**/*.coffee', ]
        dest: '<%= paths.js %>'
        ext: '.js'
      test:
        options:
          bare: true
        expand: true
        flatten: false
        cwd: '<%= paths.testsSrc %>'
        src: ['**/*.spec.coffee']
        dest: '<%= paths.testsDst %>'
        ext: '.spec.js'
    }
    uglify: {
      options:
        compress:
          drop_console: true
      files:
        expand: true
        cwd: '<%= paths.js %>'
        src: ['**/*.js', ]
        dest: '<%= paths.js %>'
    }
    clean:
      js: ["static/js/"]
  })

  grunt.registerTask('build', ['newer:coffee', 'newer:less', 'newer:copy', 'handlebars']) #'bower',
  grunt.registerTask('test', ['clean', 'build', 'karma']) #'bower',
  grunt.registerTask('default', ['build', 'watch'])
  grunt.registerTask('minify', ['build', 'uglify'])
