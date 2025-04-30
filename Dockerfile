FROM nginx:1.27.5-alpine

RUN apk update && apk add \
      git \
      gettext \
      openssh-client
WORKDIR /usr/share/nginx/html
RUN rm -r *
COPY template.conf /template.conf
COPY runner.sh /runner.sh

ENV SUBDIR /
ENV LOCATION_CFG ""
ENV SERVER_CFG ""
ENV INTERVAL 3600

CMD exec sh /runner.sh
