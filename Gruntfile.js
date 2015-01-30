// Generated on 2014-07-18 using generator-angular 0.9.5
'use strict';
// http://www.clock.co.uk/blog/a-guide-on-how-to-cache-npm-install-with-docker

var servers = {
  proxyPort: 8080,

  desktopClientFrontend: 'http://0.0.0.0:10000',
  mobileClientFrontend: 'http://0.0.0.0:9000',
  railsApiBackend: 'http://0.0.0.0:11000'
};


module.exports = function (grunt) {
  // Load grunt tasks automatically
  require('load-grunt-tasks')(grunt);

  // Define the configuration for all the tasks
  grunt.initConfig({
    shell: {
      startDesktopClientFrontend: {
        command: "grunt serve",
        options: {
          async: true,
          execOptions: {
            cwd: './desktop-client-frontend'
          }
        }
      },
      startMobileClientFrontend: {
        command: "grunt serve",
        options: {
          async: true,
          execOptions: {
            cwd: './mobile-client-frontend'
          }
        }
      },
      startRailsApiBackend: {
        command: 'bundle exec rackup -p 11000',
        options: {
          async: true,
          execOptions: {
            cwd: './rails-api-backend'
          }
        }
      }
    },
  });

  grunt.registerTask('serveProxy', 'Start the proxy to the various servers', function() {
    var done = this.async();
    
    var http = require('http'),
        url = require('url'),
        httpProxy = require('http-proxy'),
        MobileDetect = require('mobile-detect');

    var proxy = httpProxy.createProxyServer({});

    proxy.on('error', function (err, req, res) {
      
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
          proxy.web(req, res, { target: servers.mobileClientFrontend });
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
      'shell:startDesktopClientFrontend',
      'shell:startMobileClientFrontend',
      // 'shell:startRailsApiBackend',
      'serveProxy'
    ]);
  });

  grunt.loadNpmTasks('grunt-shell-spawn');

      
};




