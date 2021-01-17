FROM debian:buster
#PEUT ETRE PAS NECESSAIRE WORKDIR -> permet de se mettre dans un directory au demarrage.
#COPY . .
RUN apt -y update && apt -y install nginx
CMD service nginx start && bash