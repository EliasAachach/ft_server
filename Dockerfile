FROM debian:buster
#PEUT ETRE PAS NECESSAIRE WORKDIR -> permet de se mettre dans un directory au demarrage.
COPY ./srcs .
RUN apt -y update && apt -y install nginx
CMD mkdir -p /var/www/your_domain/html && chown -R $USER:$USER /var/www/your_domain/html && chmod -R 755 /var/www/your_domain && mv index.html /var/www/your_domain/html/ && mv your_domain /etc/nginx/sites-available/ && ln -s /etc/nginx/sites-available/your_domain /etc/nginx/sites-enabled/ && mv nginx.conf /etc/nginx && service nginx start && bash