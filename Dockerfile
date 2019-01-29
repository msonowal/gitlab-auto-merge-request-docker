FROM alpine:3.8
MAINTAINER Manash Jyoti Sonowal <manash149@gmail.com>

RUN apk add --no-cache \
  bash \
  curl \
  grep \
  jq

COPY set-target-branch.sh /usr/bin/

RUN chmod +x /usr/bin/set-target-branch.sh

COPY merge-request.sh /usr/bin/

RUN chmod +x /usr/bin/merge-request.sh

CMD ["merge-request.sh"]
