sudo yum install bind-libs bind bind-utils -y
sudo yum install nmap -y
sudo firewall-cmd --zone=public --add-port=53/tcp --permanent
sudo firewall-cmd --zone=public --add-port=53/udp --permanent
sudo firewall-cmd --reload
sudo sed -i -e 's/127.0.0.1;/127.0.0.1;10.1.0.5;/g' /etc/named.conf
sudo sed -i -e 's/localhost;/any;/g' /etc/named.conf
sudo sed -i -e 's/recursion yes;/recursion yes;\nforwarders {\n208.67.222.222;\n208.67.220.220;\n};/g' /etc/named.conf
sudo echo -e "        zone "prod.azure.oami.eu" in {\n                type forward;\n                forwarders { 168.63.129.16; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "nonprod.azure.oami.eu" in {\n                type forward;\n                forwarders { 168.63.129.16; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "blob.core.windows.net" in {\n                type forward;\n                forwarders { 168.63.129.16; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "file.core.windows.net" in {\n                type forward;\n                forwarders { 168.63.129.16; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "queue.core.windows.net" in {\n                type forward;\n                forwarders { 168.63.129.16; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "table.core.windows.net" in {\n                type forward;\n                forwarders { 168.63.129.16; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "azurecr.io" in {\n                type forward;\n                forwarders { 168.63.129.16; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "mysql.database.azure.com" in {\n                type forward;\n                forwarders { 168.63.129.16; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "mariadb.database.azure.com" in {\n                type forward;\n                forwarders { 168.63.129.16; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "prod.aws.oami.eu" in {\n                type forward;\n                forwarders { 172.22.0.201;172.22.0.246; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "nonprod.aws.oami.eu" in {\n                type forward;\n                forwarders { 172.22.0.201;172.22.0.246; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "arch.oami.eu" in {\n                type forward;\n                forwarders { 10.133.36.10; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "auth.tmdn.org" in {\n                type forward;\n                forwarders { 10.133.36.10; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "corauth.tmdn.org" in {\n                type forward;\n                forwarders { 10.133.36.10; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "dev.oami.eu" in {\n                type forward;\n                forwarders { 10.133.36.10; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "ibd.prod.oami.eu" in {\n                type forward;\n                forwarders { 10.133.36.10; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "intauth.tmdn.org" in {\n                type forward;\n                forwarders { 10.133.36.10; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "oami.eu.int" in {\n                type forward;\n                forwarders { 10.133.36.10; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "ppauth.tmdn.org" in {\n                type forward;\n                forwarders { 10.133.36.10; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "prod.oami.eu" in {\n                type forward;\n                forwarders { 10.133.36.10; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "test.oami.eu" in {\n                type forward;\n                forwarders { 10.133.36.10; } ;\n                forward only;\n        };" >> /etc/named.conf
sudo echo -e "        zone "testauth.tmdn.org" in {\n                type forward;\n                forwarders { 10.133.36.10; } ;\n                forward only;\n        };" >> /etc/named.conf










sudo service named start