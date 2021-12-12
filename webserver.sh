#!/bin/bash

echo "Menyiapkan Installasi Web server"    
sudo apt-get update    

echo "Melakukan Installasi Webserver"    
sudo apt-get install -y apache2 php php-mysql mysql-client libapache2-mod-php
echo "Installasi Selesai"    

# KONFIGURASI DIREKTORI WEB CONTENT
echo "Membuat Direktori Server Blocks"
sudo mkdir -p /var/www/html/sosmed
sudo mkdir -p /var/www/html/wordpress
sudo mkdir -p /var/www/html/landingpage
echo "========================="

echo "Set Ownership Direktori Server Blocks"
sudo chown -R vagrant:vagrant /var/www/html/landingpage
sudo chown -R vagrant:vagrant /var/www/html/wordpress
sudo chown -R vagrant:vagrant /var/www/html/sosmed
echo "========================="

echo "Set Permission Folder /var/www/"
sudo chmod -R 755 /var/www/html
echo "Konfigurasi Direktori Web Content Selesai"
echo "========================"

# CLONE SOURCE CODE
echo "Clone Source Code landing-page"
git clone https://github.com/gustysap/landing-page.git
mv landing-page/* /var/www/html/landingpage
rm -rf landing-page
 
echo "Clone Source Code WordPress"
git clone https://github.com/gustysap/WordPress.git
mv WordPress/* /var/www/html/wordpress
rm -rf WordPress
sudo cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
sudo sed -i 's/database_name_here/wordpress_db/g' /var/www/html/wordpress/wp-config.php
sudo sed -i 's/username_here/devopscilsy/g' /var/www/html/wordpress/wp-config.php
sudo sed -i 's/password_here/1234567890/g' /var/www/html/wordpress/wp-config.php
sudo sed -i 's/localhost/192.168.56.56/g' /var/www/html/wordpress/wp-config.php
echo "========================"

echo "Clone Source Code sosial-media"
git clone https://github.com/gustysap/sosial-media.git
mv sosial-media/* /var/www/html/sosmed
rm -rf sosial-media
sed -i 's/localhost/192.168.56.56/g' /var/www/html/sosmed/config.php
echo "Clone Source Code Selesai"
echo "dump sql"
mysql -h 192.168.56.56 -u devopscilsy -p1234567890 dbsosmed < /var/www/html/sosmed/dump.sql
echo "========================"


echo "Konfigurasi Apache"
sudo cp /vagrant/landingpage.conf /etc/apache2/sites-enabled/
sudo cp /vagrant/wordpress.conf /etc/apache2/sites-enabled/
sudo cp /vagrant/sosmed.conf /etc/apache2/sites-enabled/
echo "========================"

echo "Restart Service"
sudo systemctl restart apache2
echo "Konfigurasi Apache Selesai"
echo "========================"
