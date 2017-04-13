#!/bin/bash


echo "Starting disk-cleanup..."

sed -i -e "s/\${cron_cleanup_hours}/${cron_cleanup_hours}/" -e "s/\${cron_cleanup_hourstodelete}/${cron_cleanup_hourstodelete}/" /var/spool/cron/crontabs/root

crond -l 0 -f -L /var/sky/log/disk-cleanup/cron.log