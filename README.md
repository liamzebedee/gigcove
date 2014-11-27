GigCove
=======

## Install
Install docker, fig
Run `fig build`
Run `fig up` and boom

For deployment:
`gem install mina`

## Development
Mina for deployment
```
git remote add origin git@gigcove.com:gigcove-main.git
git push origin master # update repo
mina deploy # mina adds code
# manual start/stop of fig
#!/bin/sh
GIT_WORK_TREE=/home/gigcove/gigcove-main.git GIT_DIR=/home/gigcove/gigcove-main.git git pull origin master
```

## Maintenance
rake db:migrate RAILS_ENV=development
Use rake secret to generate new keys for the development and test sections.

### Install
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
```

### Deployment
```
fig run web rake db:create
fig run web rake db:migrate
fig run web rake assets:precompile
fig build
fig up
```

rsync -azP --xattrs --delete --filter=':- .gitignore' . git@gigcove.com:/home/git/gigcove-production