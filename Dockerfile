FROM node:20.10.0 as build

WORKDIR /usr/local/app

COPY ./ /usr/local/app/

# Install Chrome for Karma tests
RUN apt-get update && apt-get install -y wget gnupg \
    && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list' \
    && apt-get update && apt-get install -y google-chrome-stable \

RUN npm install

RUN npm run test

RUN npm run build

FROM nginx:latest

COPY --from=build /usr/local/app/dist/browser /usr/share/nginx/html

EXPOSE 80
