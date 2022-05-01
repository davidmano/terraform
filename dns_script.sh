sudo yum install bind-libs bind bind-utils -y
sudo yum install nmap -y
sudo firewall-cmd --zone=public --add-port=53/tcp --permanent
sudo firewall-cmd --zone=public --add-port=53/udp --permanent
sudo firewall-cmd --reload
sudo sed -i -e 's/127.0.0.1;/127.0.0.1;10.1.0.5;/g' /etc/named.conf
sudo sed -i -e 's/localhost;/any;/g' /etc/named.conf
sudo sed -i -e 's/recursion yes;/recursion yes;\nforwarders {\n208.67.222.222;\n208.67.220.220;\n};/g' /etc/named.conf
sudo echo -e "        zone "davidmn.com" in {\n                type forward;\n                forwarders { 168.63.129.16; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo service named start