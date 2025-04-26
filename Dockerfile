FROM node:23-alpine

WORKDIR /docs
RUN npm install -g docsify-cli@4.4.4
RUN apk update && apk add \
      git \
      gettext \
      openssh-client
COPY runner.sh /runner.sh
ENV INTERVAL 3600
CMD exec sh /runner.sh
