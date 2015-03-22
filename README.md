Gigcove
=======

Here is the source code for [Gigcove](http://gigcove.tumblr.com), a web app I originally started in Jan'2013 for building the best way to find live music gigs around in Brisbane. Since then it has undergone about 6 rewrites (from terrible Rails + JQuery spaghetti, to nicer AJAX Rails + JQuery spaghetti, to Bootstrap, now with Docker, to Ratchet and React.js, to Ionic w/ Angular, to Ionic and Semantic UI w/ Angular) and I've learnt **a lot**. I'm going to write a blog post later about the entire experience.

Copyright Liam Edwards-Playne, 2015. **Licensed under GPL v3**. Send me an email if you're interested on how it works. Read [the arch doc](ARCH.md) for a basic introduction to the code.

## Install
You should be running a Linux-based system to host GigCove. We use Ubuntu 14.04 LTS. 
 1. Install Docker (docker-lxc) and [Docker Compose](http://fig.sh) using `pip install docker-compose==1.1.0-rc2`
 2. Run `docker-compose build`
 3. `docker-compose up --no-build`
 3. Install+cache the Bundler gems (see below)
 4. Install+cache the Node packages
 5. `docker-compose up proxy`

### Desktop and Mobile clients
`docker-compose up desktop`
`docker-compose up mobile`

If you re-`build` any of the images, you must run the `up` twice, otherwise you'll get a timeout error probably.

You can update NPM and Bower packages by `docker-compose run desktop bash` 

### Bundler Gem caching
Run `docker-compose run api bundle package` to store the gems to your local machine cache, such that when you rebuild the Docker image it doesn't need to redownload all of these gems

## Deployment
### Creating remote Git server
```
useradd git
passwd git
mkdir /home/git
mkdir /home/git/gigcove.com # Mina deployment path
chown -R git /home/git
apt-get install git
#### add ssh keys to ~/.ssh/authorized_keys
mkdir ~/.ssh && touch ~/.ssh/authorized_keys
cat ~/.ssh/id_rsa.pub | ssh git@gigcove.com "cat >> ~/.ssh/authorized_keys"
su git
git init --bare gigcove-main.git
#### push from home
git remote set-url origin git@gigcove.com:gigcove-main.git

# install necessary software
curl -L https://github.com/docker/fig/releases/download/0.5.2/linux > /usr/local/bin/fig
chmod +x /usr/local/bin/fig

git remote add origin git@gigcove.com:gigcove-main.git
git push origin master # update repo
mina deploy # mina adds code
# manual start/stop of fig
#!/bin/sh
GIT_WORK_TREE=/home/gigcove/gigcove-main.git GIT_DIR=/home/gigcove/gigcove-main.git git pull origin master
```

### Deploying code to production
```
rsync -azP --xattrs --delete --filter=':- .gitignore' . git@gigcove.com:/home/git/gigcove-production
```

## Thanks
Gigcove is built on this fantastic open-source tech stack (excluding Google Maps):
 - [Docker](https://www.docker.com/) and [Fig](http://fig.sh) (now Docker Compose) for containerization and deployment
 - [Ubuntu Linux](http://www.ubuntu.com/) for the underlying OS
 - [Ruby on Rails](http://rubyonrails.org/) for the REST API backend
 - [Postgres](http://www.postgresql.org/) for the API database
 - [Postfix](http://www.postfix.org/) for the mail server (for registrations and the like)
 - [Grunt](http://gruntjs.com/)/[Node.js](https://nodejs.org/) for the serving of the desktop/mobile clients
 - [AngularJS](https://angularjs.org/) for the interactivity of the desktop and mobile clients
 - [Ionic](http://ionicframework.com) for the mobile client UI and interactivity
 - [Semantic UI](http://semantic-ui.com) for the desktop client UI
 - [Lodash](https://lodash.com/) for useful JS (array functions etc.)
 - [Sugar](http://sugarjs.com/dates) for natural-language date parsing (used in the search interface)
 - [Google Maps](https://developers.google.com/maps/documentation/javascript/) for geolocation
 - [Geokit (Rails)](https://github.com/geokit/geokit-rails) for adding location capabilites to ActiveRecord models
 - [angular-datepicker](https://github.com/g00fy-/angular-datepicker) for a nice datetime picker interface