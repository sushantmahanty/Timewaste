Helper Script:

Description: Supports Creating Code Deploy Structure and Stopping Servicees

wget https://raw.githubusercontent.com/sushantmahanty/Timewaste/main/helper

bash helper

Elasticsearch Install Script: Compatible for Installing 7.7.x Later Version on ARM Architecture

wget https://raw.githubusercontent.com/sushantmahanty/Timewaste/main/esinstall.sh

chmod +x esinstall.sh

./esinstall.sh

Redis Install Pending (Plan):

Reference Packages: http://download.redis.io/releases/

Compile the package on AMI 

wget http://download.redis.io/releases/redis-4.0.0.tar.gz

tar -xzvf redis-stable.tar.gz

cd redis-stable

make

1.Make a script to download the package & compile it

2.then zip the binaries and upload it using transfer.sh

3.then on actual server wget the binaries on usr/bin or /usr/local/bin

Varnish Install Pending:
