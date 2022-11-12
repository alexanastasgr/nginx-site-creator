#!/bin/sh

sEnabled="/etc/nginx/sites-enabled"
sAvailable="/etc/nginx/modules-available"
webroot="/var/www"


# prompt sitename from user
echo "Enter new sitename: "
read sitename

# create the folder in webroot
cd $webroot
mkdir $sitename

# change owner
sudo chown -R $USER:$USER "$webroot/$website"


bluePrintScript="
server {
    listen 80;
    server_name $sitename www.$sitename;
    root /var/www/$sitename;

    index index.html index.htm index.php;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
     }

    location ~ /\.ht {
        deny all;
    }

}


"
