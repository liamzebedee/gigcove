DOCS
====

http://api.rubyonrails.org/
http://ionicframework.com/docs/components/
https://docs.angularjs.org/api/ng/service/
http://ionicons.com/1.5.2/animation.html
http://ionicons.com/

https://github.com/Instagram/instagram-ruby-gem
http://rubydoc.info/github/Instagram/instagram-ruby-gem/Instagram/Configuration#configure-instance_method


Testing
=======

Test different services individually like so:
`sudo docker-compose up --no-build api`



Philosophy/Principles
=====================

Move fast and break things
Don't work against the code, work with whatever the accepted way is
Make it pretty
Don't theorise, write code and test
Make it illegal on the frontend, and a minimal backend: backend is security and data
`git rev-list HEAD --count` makes me feel good.


Deployment
==========

ssh git@gigcove.com
cd /home/git/gigcove-production
rsync -azP --xattrs --delete --filter=':- .gitignore' . git@gigcove.com:/home/git/gigcove-production