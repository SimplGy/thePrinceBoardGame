LIVERELOAD_PORT = 35729
lrSnippet = require("connect-livereload")(port: LIVERELOAD_PORT)
mountFolder = (connect, dir) ->
  connect.static require("path").resolve(dir)


# # Globbing
# for performance reasons we're only matching one level down:
# 'test/spec/{,*/}*.js'
# use this if you want to recursively match all subfolders:
# 'test/spec/**/*.js'
module.exports = (grunt) ->

  # show elapsed time at the end
  require("time-grunt") grunt

  # load all grunt tasks
  require("load-grunt-tasks") grunt

  # configurable paths
  yeomanConfig =
    app: "app"
    dist: "dist"
    tmp: '.tmp'

  grunt.initConfig
    yeoman: yeomanConfig
    watch:

      styles:
        files: ["<%= yeoman.app %>/styles/{,*/}*.css"]
        tasks: ["copy:styles"]

      livereload:
#        options:
#          livereload: LIVERELOAD_PORT

        files: [
          "<%= yeoman.app %>/*.html"
          "<%= yeoman.app %>/{,*/}{,*/}{,*/}*.css"
          "<%= yeoman.app %>/{,*/}{,*/}{,*/}*.js"
          "<%= yeoman.app %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}"
        ]

    connect:
      options:
        port: 3001
        hostname: "0.0.0.0"

      livereload:
        options:
          keepalive: true
          livereload: LIVERELOAD_PORT
          middleware: (connect) ->
            [
#              lrSnippet
              mountFolder(connect, yeomanConfig.tmp)
              mountFolder(connect, yeomanConfig.app)
            ]

      dist:
        options:
          middleware: (connect) ->
            [mountFolder(connect, yeomanConfig.dist)]

    open:
      server:
        path: "http://localhost:<%= connect.options.port %>"

    clean:
      dev:
        files: [
          dot: true
          src: [".tmp"]
        ]
      dist:
        files: [
          dot: true
          src: [".tmp", "<%= yeoman.dist %>/*"]
        ]

      server: ".tmp"



    # Try, try again.
    useminPrepare:
      options:
        dest:    "<%= yeoman.dist %>"
        staging: "<%= yeoman.dist %>" # put unminified files in dist for easier debugging. Easy to minify later.
        flow:
          steps:
            css: [ 'concat' ]
            js:  [ 'concat' ]
          post: {}
      html: "<%= yeoman.app %>/index.html"

    usemin:
      html: ["<%= yeoman.dist %>/index.html"]
#      css:  ["<%= yeoman.dist %>/styles/{,*/}*.css"]



  # Put files not handled in other tasks here
    copy:
      dist:
        files: [
          expand: true
          dot: true
          cwd: "<%= yeoman.app %>"
          dest: "<%= yeoman.dist %>"
          src: [
            "*.{ico,png,txt}"
            "index.html"
            ".htaccess"
            "images/{,*/}*.{webp,gif}"
          ]
        ]


  # --------------------------------- Server Tasks
  grunt.registerTask "server", [
    "open"
    "connect:livereload"
  ]


  # --------------------------------- Build Tasks
  grunt.registerTask "buildDev", [
    "clean:dev" # Basically a noop right now, but you'll need it soon
  ]

  grunt.registerTask "dist", [
    "clean:dist"
    "copy:dist"
    "useminPrepare"
    "concat"
    "usemin"
  ]


  grunt.registerTask "default", ["clean", "buildDev", "server"]
