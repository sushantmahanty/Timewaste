#!/bin/bash
echo -e "\nThis Script is Only Intended for Debian ARM Elasticsearch Installation.\nCompatible with ES 7.7.x Later Versions \nYou can find the versions here visit https://www.elastic.co/downloads/past-releases/#elasticsearch \n"

remove_es () {
apt-get -y --purge autoremove elasticsearch
rm -rf /var/lib/elasticsearch/
rm -rf /etc/elasticsearch
rm -rf /home/elasticsearch
}

install_es () {
dpkg -i /home/mgt/tmp_es/*.deb
systemctl daemon-reload
systemctl enable elasticsearch.service
mv /var/lib/elasticsearch /home/
cd /var/lib
ln -s /home/elasticsearch .
chown -h elasticsearch:elasticsearch elasticsearch
cd /usr/share/elasticsearch
bin/elasticsearch-plugin install analysis-phonetic
bin/elasticsearch-plugin install analysis-icu
echo '-Xms2g' >> /etc/elasticsearch/jvm.options
echo '-Xmx2g' >> /etc/elasticsearch/jvm.options
systemctl restart elasticsearch
rm -rf /home/mgt/tmp_es/
curl -X GET 'http://127.0.0.1:9200'
echo -e "Elasticsearch $es Installed\nInsert Following line in ES [Service] section so it can take care when ES Crashes \nnano /lib/systemd/system/elasticsearch.service \nRestart=always\nRestartSec=3"
}

check_es () {
rm -rf /home/mgt/tmp_es/
mkdir -p /home/mgt/tmp_es/
cd /home/mgt/tmp_es/

wget_result="$(wget -NS https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$es-arm64.deb 2>&1|grep "HTTP/"|awk '{print $2}')"

if [ $wget_result = 200 ]; then
echo "Package Available"
remove_es
install_es
else
rm -rf /home/mgt/tmp_es/
echo "Unfortunately that package version is not available"
echo "You can find the versions here visit https://www.elastic.co/downloads/past-releases/#elasticsearch"
    exit 1
fi
}

check_arch() {
arch=$(arch)
if [[ $arch == aarch64 ]]; then
    es_ver
elif [[ $arch == arm* ]]; then
    es_ver
else
    echo "Not for x86 or other architectures bro maybe you should try learning how to install things ?"
fi
}

es_ver () {
read -p "Enter the ElasticSearch Version: " es
check_es $es
}

check_arch
