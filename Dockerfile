FROM debian:buster
#PEUT ETRE PAS NECESSAIRE WORKDIR -> permet de se mettre dans un directory au demarrage.
COPY ./srcs .
RUN apt -y update && apt -y install nginx && apt -y install mariadb-server && apt -y install php-fpm php-mysql
CMD mkdir -p /var/www/your_domain/html && chown -R $USER:$USER /var/www/your_domain && chmod -R 755 /var/www/your_domain && mv index.html /var/www/your_domain/html/ && mv your_domain /etc/nginx/sites-available/ && ln -s /etc/nginx/sites-available/your_domain /etc/nginx/sites-enabled/ && mv nginx.conf /etc/nginx && service php7.3-fpm start && service nginx start && /etc/init.d/mysql start && mysql -uroot -e 'USE mysql; UPDATE `user` SET `Host`="%" WHERE `User`="root" AND `Host`="localhost"; DELETE FROM `user` WHERE `Host` != "%" AND `User`="root"; FLUSH PRIVILEGES;' && mv info.php todo_list.php /var/www/your_domain && mariadb -e "GRANT ALL ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'admin' WITH GRANT OPTION; FLUSH PRIVILEGES;" && mariadb -uadmin -padmin -e "CREATE DATABASE example_database; CREATE TABLE example_database.todo_list (item_id INT AUTO_INCREMENT, content VARCHAR(255), PRIMARY KEY(item_id));" && bash
#mariadb -e "GRANT ALL ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'admin' WITH GRANT OPTION;"
#^- crée un user admin:admin avec tous les droits
#mariadb -uadmin -padmin -e "CREATE TABLE example_database.olala (item_id INT AUTO_INCREMENT, content VARCHAR(255), PRIMARY KEY(item_id));"
#cree une db
#mariadb -uadmin -padmin -e "CREATE DATABASE example_database; CREATE TABLE example_database.todo_list (item_id INT AUTO_INCREMENT, content VARCHAR(255), PRIMARY KEY(item_id));"