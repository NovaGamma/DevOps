#!/bin/bash
echo "Adding apt-keys"
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

echo "Updating apt-get"
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get upgrade -y

echo "Installing java"
sudo apt-get install -y openjdk-11-jre openjdk-11-jdk
java -version

echo "Installing git"
sudo apt-get -y install git

echo "Installing git-ftp"
sudo apt-get -y install git-ftp

echo "Installing node js"
sudo apt-get install -y nodejs

echo "Installing jenkins"
sudo apt-get install -y --allow-unauthenticated jenkins

echo "Put online"
filename="/var/lib/jenkins/hudson.model.UpdateCenter.xml"
sudo sed -i "s/https/http/" $filename
sudo /var/lib/dpkg/info/ca-certificates-java.postinst configure

/usr/bin/printf '\xfe\xed\xfe\xed\x00\x00\x00\x02\x00\x00\x00\x00\xe2\x68\x6e\x45\xfb\x43\xdf\xa4\xd9\x92\xdd\x41\xce\xb6\xb2\x1c\x63\x30\xd7\x92' > /etc/ssl/certs/java/cacerts
/var/lib/dpkg/info/ca-certificates-java.postinst configure

echo "Copy jenkins configuration"
sudo cp -rfT /vagrant/backup/jenkins /var/lib/

echo "Restart jenkins"
sudo systemctl restart jenkins

echo "Password"
JENKINSPWD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
echo $JENKINSPWD