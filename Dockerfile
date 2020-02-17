FROM node:12
WORKDIR /usr/src/app
COPY package*.json ./
COPY . .
RUN npm install -g @angular/cli@latest
EXPOSE 4200
CMD [ "ng", "serve" , "--host" , "0.0.0.0" ]

