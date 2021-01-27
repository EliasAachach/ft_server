FROM debian:buster
#COPY . .
RUN apt -y update && apt -y install mariadb-server
CMD /etc/init.d/mysql start && mysql -uroot -e 'USE mysql; UPDATE `user` SET `Host`="%" WHERE `User`="root" AND `Host`="localhost"; DELETE FROM `user` WHERE `Host` != "%" AND `User`="root"; FLUSH PRIVILEGES;' && bash