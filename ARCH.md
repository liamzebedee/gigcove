# Zero downtime
Grunt servers need to npm install, start and serve assets.
Rails servers need to do DB migrations, bundle install, etc.

Solution:
http://blog.argteam.com/coding/hardening-node-js-for-production-part-3-zero-downtime-deployments-with-nginx/

 1. fall-over for all servers in nginx configuration
 2. run fig up which will start the mail and db servers
 3. run a web worker which will accept requests on port 8080

on deploy/update:
 - run another web worker on port 8081
 - kill old web container
 - nginx will forward requests to fallback server on 8081
 - when new server is up, requests will go to new server

# Collaboration with multiple developers
Git repository for entire repo
https://github.com/mina-deploy/mina Mina for deployment and automation
