#!/bin/bash

# アップデート
sudo apt-get update -y
sudo apt-get upgrade -y

# luaセットアップ
sudo apt-get install unzip -y
curl -L http://git.io/lenv | perl
## .bashrcに追記
cat << EOS >> ~/.bashrc
if [ -f ~/.lenvrc ]; then
    source ~/.lenvrc
fi
EOS
source ~/.lenvrc
## ダウンロード
lenv fetch
lenv install-lj 2.0.4
lenv use-lj 2.0.4

# luarocks
mkdir ~/.luarocks
cd ~/.luarocks
cat << EOS >> ~/.luarocks/config.lua
rocks_servers = { 
    "http://mah0x211.github.io/rocks/",
    "http://yanoshi.github.io/rocks",
    -- default rocks server
    "http://rocks.moonscript.org/",
    "http://luarocks.org/repositories/rocks"
}
EOS

# OpenResty
cd ~/
sudo apt-get install -y libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make build-essential
wget https://openresty.org/download/openresty-1.11.2.2.tar.gz
tar -xvf openresty-1.11.2.2.tar.gz
cd openresty-1.11.2.2/
./configure -j2
make -j2
sudo make install

mkdir -p ~/app/conf
mkdir ~/app/logs
if [ -f /vagrant/nginx.conf ]; then
    cp /vagrant/nginx.conf ~/app/conf/
else
    cp /vagrant/nginx.conf.example ~/app/conf/nginx.conf
fi

if [ -f /vagrant/nginx ]; then
    sudo cp /vagrant/nginx /etc/init.d/
else
    sudo cp /vagrant/nginx.example /etc/init.d/nginx
fi
sudo chmod +x /etc/init.d/nginx
sudo update-rc.d -f nginx defaults
sudo service nginx start
