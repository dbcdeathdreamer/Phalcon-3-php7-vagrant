#!/usr/bin/env bash

APACHESERVERNAME="ServerName localhost"

# add php7 ppa
add-apt-repository -y ppa:ondrej/php > /dev/null 2>&1

# update system
apt-get -qq update

# install apache2
if ! [ -a /usr/sbin/apache2 ]
    then
        echo "Installing apache2"
        apt-get -qq install -y apache2
fi

# install unzip
if ! [ -a /usr/bin/unzip ]
    then
        echo "Installing unzip"
        apt-get -qq install -y unzip
fi

# install & config git
if ! [ -a /usr/bin/git ]
    then
        echo "Installing git"
        apt-get -qq install -y git
fi

# install php
if ! [ -a /usr/bin/php ]
    then
        echo "Installing php"
        apt-get -qq install -y php7.0 php7.0-common php7.0-curl php7.0-mysql php7.0-cli php7.0-gd php7.0-intl php7.0-pgsql php7.0-mbstring  php7.0-xml php-msgpack php7.0-zip php7.0-soap php-imagick php-xdebug libapache2-mod-php7.0
        sudo apt-get install -y gcc make re2c libpcre3-dev php7.0-dev build-essential php7.0-zip
fi

# install/config mysql server & client
if ! [ -a /usr/bin/mysql ]
    then
        echo "Installing mysql"
        debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
        debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'
        apt-get -qq install -y mysql-client mysql-server
fi

# setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
    DocumentRoot "/var/www/html/example1/root"
    <Directory "/var/www/html/example1/root">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

# install composer
if ! [ -a /usr/local/bin/composer ]
    then
        curl -sS https://getcomposer.org/installer | php
        mv composer.phar /usr/local/bin/composer
fi



# create database
mysql -uroot -pvagrant -e"CREATE DATABASE IF NOT EXISTS main;"

# add vagrant user to www-data group
usermod -a -G www-data vagrant

# grant www-data (group) access to logs
chgrp -R www-data /var/log/apache2

# enable rewrite module
a2enmod rewrite

# php configuration
sed -i '/memory_limit = 128M/c\memory_limit = 256M' /etc/php/7.0/apache2/php.ini
sed -i '/upload_max_filesize = 2M/c\upload_max_filesize = 6M' /etc/php/7.0/apache2/php.ini
sed -i '/max_execution_time = 30/c\max_execution_time = 120' /etc/php/7.0/apache2/php.ini
sed -i '/; max_input_vars = 1000/c\max_input_vars = 1500' /etc/php/7.0/apache2/php.ini
sed -i '/post_max_size = 8M/c\post_max_size = 10M' /etc/php/7.0/apache2/php.ini
echo 'xdebug.max_nesting_level = 400' >> /etc/php/7.0/apache2/php.ini

# check apache conf
if [[ $(tail -1 /etc/apache2/apache2.conf) != $APACHESERVERNAME ]]
    then
	    echo $APACHESERVERNAME >> /etc/apache2/apache2.conf
fi

sudo apt-get install -y php-memcached
sudo apt-get install memcached
sudo service memcached restart

sudo composer global require "phalcon/zephir:dev-master" 

# Install phalconphp with php7
sudo git clone https://github.com/phalcon/cphalcon.git 
cd cphalcon/
sudo ~/.composer/vendor/bin/zephir build --backend=ZendEngine3
service apache2 restart
sudo -s
echo "extension=phalcon.so" >> /etc/php/7.0/apache2/conf.d/20-phalcon.ini
sudo echo "extension=phalcon.so" >> /etc/php/7.0/cli/conf.d/20-phalcon.ini
service apache2 restart

sudo apt-get update

# restart services
service apache2 restart
service mysql restart
