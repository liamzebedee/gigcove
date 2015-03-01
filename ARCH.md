Everything is containerized by **Docker** and **Compose**/Fig. This is for a couple reasons:
 - easier to deploy on development and production when we can replicate the exact environment and configuration
 - easier to link servers together when they're all orchestrated centrally
 - good for security - the comprimise of one service (mail server for example) remains isolated

There are multiple services. 
 - The backend is built on **Rails**, because of its ORM and abundance of libraries. It consists of a HTTP JSON-based API. **gigcove.com/api/** is the root path for this API. POST requests encode their parameters using JSON. GET requests encode their parameters in a JSON string mapped by the `q` URL parameter.
 - The desktop frontend is an AngularJS app built using the Semantic UI framework.
 - The mobile frontend is an AngularJS app built using the Ionic framework.
 - A Node proxy redirects requests to either of the frontends by checking the user agent.

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
