FROM debian:buster

#setting up the author
LABEL elaacahc <elaachac@student.42.fr>


#update & install packages
RUN apt -y update
RUN apt -y install mariadb-server
RUN apt -y install wget
RUN apt -y install nginx
RUN apt -y install php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline php-mbstring

#set up nginx
COPY srcs/default /etc/nginx/sites-enabled/default
COPY srcs/nginx.conf /etc/nginx

#set up phpmyadmin
    #install
RUN wget https://www.phpMyAdmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
RUN tar -zxvf phpMyAdmin-latest-all-languages.tar.gz && rm -rf *.tar.gz
RUN mv phpMyAdmin-* /var/www/html/phpmyadmin
    #config file
COPY srcs/config.inc.php /var/www/html/phpmyadmin/
    #permissions
RUN chmod -R 660 /var/www/html/phpmyadmin/config.inc.php
RUN chown -R www-data:www-data /var/www/html/phpmyadmin

#set up mariadb
    #create a db for wordpress
RUN service mysql start && mariadb -e "CREATE DATABASE wordpress; FLUSH PRIVILEGES;"
    #create a user for phpmyadmin and wordpress
RUN service mysql start && mariadb -e "GRANT ALL ON wordpress.* TO 'admin'@'localhost' IDENTIFIED BY 'admin' WITH GRANT OPTION; FLUSH PRIVILEGES;"

#lauching services
ENTRYPOINT service nginx start && service mysql start && service php7.3-fpm start && bash
