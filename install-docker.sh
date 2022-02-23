#!/bin/bash

# check root
[[ $EUID -ne 0 ]] && echo -e "${red}错误：${plain} 必须使用root用户运行此脚本！\n" && exit 1

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm -f get-docker.sh

systemctl enable --now docker

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

mkdir -p /data/danted
cd /data/danted
curl http://104.225.156.231/docker-compose.yml -o docker-compose.yml
touch sockd.passwd
docker-compose up -d
docker-compose exec sockd script/pam add socksuser 36U524A19611BEW424F
