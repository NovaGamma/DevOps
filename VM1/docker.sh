#!/bin/bash
apt-get update
apt-get install -y docker.io
usermod -aG docker vagrant

#sudo docker run --name some-nginx -d -p 8080:80 nginx
#filename="/lib/systemd/system/docker.service"
#sed -i 's/^ExecStart.*$/ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock/g' file.TXT

#sudo systemctl daemon-reload
#sudo service docker restart

#curl http://localhost:4243/version
#curl http://localhost:8080/version