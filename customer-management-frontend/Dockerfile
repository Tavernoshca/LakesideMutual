# syntax=docker/dockerfile:experimental
FROM node:10 as build
WORKDIR /usr/src/app
COPY package.json ./
COPY package-lock.json ./
RUN npm install
COPY . ./
RUN npm run build

FROM nginx:stable
COPY nginx.vh.default.conf /etc/nginx/conf.d/default.conf
COPY fix-permissions.sh /bin/
COPY --from=build /usr/src/app/build /usr/share/nginx/html
RUN fix-permissions.sh /var/cache/nginx
RUN fix-permissions.sh /usr/share/nginx/html
RUN fix-permissions.sh /var/run/
EXPOSE 80
WORKDIR /usr/share/nginx/html

RUN apt-get update && apt-get install -y npm nodejs
RUN npm install -g @beam-australia/react-env
ADD entrypoint.sh /var/entrypoint.sh
ENTRYPOINT ["/var/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]