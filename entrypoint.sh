#!/bin/bash


echo "Starting disk-cleanup..."

eval "cat <<EOF
$(</var/spool/cron/crontabs/root)
EOF" > /var/spool/cron/crontabs/root

crond -l 0 -f -L /var/sky/log/disk-cleanup/cron.log