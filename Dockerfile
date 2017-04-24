FROM alpine:latest

RUN apk add --update bash && rm -rf /var/cache/apk/*

ADD entrypoint.sh .
ADD scripts/disk-cleanup.cron /var/spool/cron/crontabs/root
ADD scripts/disk-cleanup.sh /usr/bin/disk-cleanup.sh

RUN chmod +x /usr/bin/disk-cleanup.sh
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]