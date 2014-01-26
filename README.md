Gigcove
=======

deploy:
 - stores git repos
 - perms to commit to /home/rails

# server
useradd deploy
passwd deploy
usermod -s /bin/bash -a -G sudo deploy
mkdir /home/deploy
chown deploy:deploy /home/deploy
usermod -a -G www-data deploy
chmod -vR g+w /home/rails

apt-get install git
cd ~
mkdir gigcove.git
cd gigcove.git
git --bare init

edit /home/unicorn/unicorn.conf, /etc/default/unicorn, /etc/nginx/sites-enabled/default
replace /home/rails with /home/deploy/current

# client
git remote add origin deploy@gigcove.com:gigcove.git
git push origin master
git config branch.master.remote origin
git config branch.master.merge refs/heads/master

---

sudo apt-get install ruby1.9.3 gem sqlite3 libsqlite3-dev imagemagick
sudo gem install rails
sudo gem install sqlite3 -v '1.3.8'
TotalTacoJune1997
RAILS_ENV=production rake db:create db:schema:load

