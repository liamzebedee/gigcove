Gigcove
=======

# server
apt-get install git
cd ~
mkdir gigcove.git
cd gigcove.git
git --bare init

# client
git remote add origin rails@gigcove.com:gigcove.git
git push origin master
git config branch.master.remote origin
git config branch.master.merge refs/heads/master

---

sudo apt-get install ruby1.9.3 gem sqlite3 libsqlite3-dev imagemagick
sudo gem install rails
sudo gem install sqlite3 -v '1.3.8'

RAILS_ENV=production rake db:create db:schema:load

