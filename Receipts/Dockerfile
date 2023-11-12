FROM node:18-alpine

WORKDIR /usr/src/app

COPY ./ ./

RUN npm install
RUN npm -g install pm2

CMD [ "npm", 'run', "docker" ]
