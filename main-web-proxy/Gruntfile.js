'use strict';

var servers = {
  proxyPort: 80,

  desktopClientFrontend: 'http://desktop_1:8082',
  mobileClientFrontend: 'http://mobile:8083',
  railsApiBackend: 'http://api_1:8081'
};

module.exports = function (grunt) {
  // Load grunt tasks automatically
  require('load-grunt-tasks')(grunt);

  grunt.registerTask('serveProxy', 'Start the proxy to the various servers', function() {
    var done = this.async();
    
    var http = require('http'),
        url = require('url'),
        httpProxy = require('http-proxy'),
        MobileDetect = require('mobile-detect');

    var proxy = httpProxy.createProxyServer({});

    proxy.on('error', function (err, req, res) {      
      // TODO this is not good.
      res.writeHead(500, {
        'Content-Type': 'text/plain'
      });

      res.end('Oops! Try reloading.');
    });

    var server = http.createServer(function(req, res) {
      if(url.parse(req.url).pathname.match(/^\/api\//)) {
        proxy.web(req, res, { target: servers.railsApiBackend });
      } else {
        var mobileDetect = new MobileDetect(req.headers['user-agent']);
        if(mobileDetect.mobile()) {
          //proxy.web(req, res, { target: servers.mobileClientFrontend });
          proxy.web(req, res, { target: servers.desktopClientFrontend });
        } else {
          proxy.web(req, res, { target: servers.desktopClientFrontend });
        }
      }
    });

    server.listen(servers.proxyPort, function() {
      console.log('Proxy server listening');
    });
  });

  grunt.registerTask('serve', 'Start servers and proxy', function (target) {
    grunt.task.run([
      'serveProxy'
    ]);
  });

  grunt.loadNpmTasks('grunt-shell-spawn');

      
};
