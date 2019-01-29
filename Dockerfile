FROM alpine:3.8
MAINTAINER Manash Jyoti Sonowal <manash149@gmail.com>

RUN apk add --no-cache \
  bash \
  curl \
  grep \
  jq

COPY merge-request.sh /usr/bin/

CMD ["merge-request.sh"]
