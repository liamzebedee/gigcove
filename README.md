Gigcove
=======

Here is the source code for [Gigcove](http://gigcove.tumblr.com), a web app I originally started in Jan'2013 for building the best way to find live music gigs around in Brisbane. Since then it has undergone about 6 rewrites (from terrible Rails + JQuery spaghetti, to nicer AJAX Rails + JQuery spaghetti, to Bootstrap, now with Docker, to Ratchet, to Ionic, to Ionic and Semantic UI) and I've learnt **a lot**. I'm going to write a blog post later about the entire experience.

Copyright Liam Edwards-Playne, 2015. Read [the arch doc](ARCH.md) for an introduction to the code.

## Install
You should be running a Linux-based system to host GigCove. We use Ubuntu 14.04 LTS. 
 1. Install Docker (docker-lxc) and [Docker Compose](http://fig.sh) using `pip install docker-compose==1.1.0-rc2`
 2. Run `docker-compose build`
 3. `docker-compose up --no-build`
 3. Cache the Bundler gems (see below)
 4. Cache the Node packages
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