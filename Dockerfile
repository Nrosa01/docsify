FROM nginx:1.23.2-alpine

RUN apk update && apk add \
      git \
      gettext
WORKDIR /usr/share/nginx/html
RUN rm -r *
COPY template.conf /template.conf
COPY runner.sh /runner.sh

ENV SUBDIR /
ENV LOCATION_CFG ""
ENV SERVER_CFG ""
ENV INTERVAL 3600

# NB: exec is vital to forward signals to the runner
CMD exec sh /runner.sh
