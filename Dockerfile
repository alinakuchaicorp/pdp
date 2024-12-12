FROM node:20.10.0 as build

WORKDIR /usr/local/app

COPY ./ /usr/local/app/

RUN npm install

RUN npm run test

RUN npm run build

FROM nginx:latest

COPY --from=build /usr/local/app/dist/browser /usr/share/nginx/html

EXPOSE 80
