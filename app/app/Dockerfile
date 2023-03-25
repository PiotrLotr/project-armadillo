FROM node:12.7.0-alpine

WORKDIR '/app'

COPY ./app_files/ .

RUN npm install pkg.json

EXPOSE 80
EXPOSE 27017

CMD ["node", "index.js"]
