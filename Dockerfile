FROM alpine:latest

RUN apk add --update bash && rm -rf /var/cache/apk/*

RUN mkdir -p /var/sky/gonzales/disk-cleanup/bin/
RUN mkdir -p /var/sky/log/disk-cleanup/

RUN touch /var/sky/log/disk-cleanup/disk-cleanup.log
RUN touch /var/sky/log/disk-cleanup/cron.log

ADD entrypoint.sh .
ADD scripts/disk-cleanup.cron /var/spool/cron/crontabs/root
ADD scripts/disk-cleanup.sh /var/sky/gonzales/disk-cleanup/bin/disk-cleanup.sh

RUN chmod +x /var/sky/gonzales/disk-cleanup/bin/disk-cleanup.sh
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["h", "entrypoint.sh"]/bin/bas