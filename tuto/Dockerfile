FROM debian:buster

#set up
RUN apt update
RUN apt -y upgrade
RUN apt -y install wget

#install nginx
RUN apt -y install nginx
COPY ./srcs/default /etc/sites-available

#install mariadb and make a db for wordpress
RUN apt -y install mariadb-server
RUN /etc/init.d/mysql start && mariadb -e "CREATE DATABASE wordpress; GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION; FLUSH PRIVILEGES; update mysql.user set plugin='' where user='root';"

#install phpmyadmin and config file for it
RUN apt -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring
#pas sur d'utiliser ca WORKDIR /var/www/html/
RUN wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
RUN tar -xf phpMyAdmin-latest-all-languages.tar.gz && rm -rf phpMyAdmin-latest-all-languages.tar.gz
RUN mv phpMyAdmin-* /var/www/html/phpmyadmin
COPY ./srcs/config.inc.php /var/www/html/phpmyadmin

#install & config wordpress
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
RUN mv wordpress /var/www/html
COPY ./srcs/wp-config.php /var/www/html

#SSL config
RUN openssl req -x509 -nodes -days 365 -subj "/C=KR/ST=Korea/L=Seoul/O=innoaca/OU=42seoul/CN=forhjy" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

#authorzations
RUN chown -R www-data:www-data /var/www/html/*
RUN chmod -R 755 /var/www/*

#run services 
RUN service nginx start && service mysql start && service php7.3-fpm start
#CMD