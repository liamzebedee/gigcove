GigCove
=======

Copyright Liam Edwards-Playne, 2015. Read [the arch doc](ARCH.md) for an introduction to the code.

## Install
You should be running a Linux-based system to host GigCove.
 1. Install Docker, [Fig](http://fig.sh). `pip install docker-compose==1.1.0-rc2`
 2. Run `sudo docker-compose build`
 3. `sudo docker-compose up`
 3. Cache the Bundler gems (see below)
 4. Cache the Node packages

### Bundler Gem caching
Run `fig run web bundle package` to store the gems to your local machine cache, such that when you rebuild the Docker image it doesn't need to redownload all of these gems

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

## Maintenance
rake db:migrate RAILS_ENV=
Use rake secret to generate new keys for the development and test sections.

### Deploying code to production
```
rsync -azP --xattrs --delete --filter=':- .gitignore' . git@gigcove.com:/home/git/gigcove-production
fig run web rake db:create
fig run web rake db:migrate
fig run web rake assets:precompile
fig build
fig up
```