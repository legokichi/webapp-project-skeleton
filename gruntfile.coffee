module.exports = (grunt) ->
  grunt.loadNpmTasks("grunt-contrib-coffee")
  grunt.loadNpmTasks("grunt-contrib-less")
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks("grunt-contrib-watch")
  grunt.loadNpmTasks("grunt-contrib-clean")

  grunt.initConfig
    clean:
      build:
        src: "./public/*"
    coffee:
      options:
        bare: true,
        sourceMap: true
      build:
        expand: true,
        flatten: true,
        cwd: './src/coffee/',
        src: ['*.coffee'],
        dest: './src/coffee/',
        ext: '.js'
    less:
      options:
        sourceMap: true
        outputSourceFiles: true
      build:
        expand: true,
        flatten: true,
        cwd: './src/less/',
        src: ["*.less"],
        dest: "./src/less/"
        ext: '.css'
    copy:
      build:
        filter: 'isFile',
        files: [
          {src: "./src/index.html", dest: "./public/index.html"}
          {expand: true, cwd: "./src/coffee/", src: '**', dest: './public/js/'}
          {expand: true, cwd: "./src/less/", src: '**', dest: './public/css/'}
          #{expand: true, cwd: "./bower_components/jquery/dist/", src: '*.js', dest: './public/js/'}
        ]
    watch:
      coffee:
        files:["./src/coffee/*.coffee"],
        tasks:["make"]
      less:
        files:["./src/less/*.less"],
        tasks:["make"]
      html:
        files:["./src/*.html"]
        tasks:["make"]


  grunt.registerTask("make", ["clean:build", "coffee:build", "less:build", "copy:build"])
  grunt.registerTask("default", ["make"])
