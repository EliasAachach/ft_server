FROM debian:buster
#PEUT ETRE PAS NECESSAIRE WORKDIR -> permet de se mettre dans un directory au demarrage.
COPY . .
RUN yarn install --production
CMD ["node", "src/index.js"]
