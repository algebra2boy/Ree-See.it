FROM ubuntu

WORKDIR /usr/src/app

COPY ./ ./
RUN apt-get update && apt-get install -y build-essential
RUN apt-get -y install nodejs npm

RUN npm install
# RUN npm i sharp
RUN npm -g install pm2

CMD [ "npm", "run", "docker" ]
