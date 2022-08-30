#!/bin/sh
for file in $(ls /var/log/maillog-*); do mv "$file" /var/log/$(hostname -s).$(basename "$file"); done
/usr/local/bin/aws s3 cp --sse='AES256' /var/log/ s3://shared-services.eu-west-2.smtplog.ch.gov.uk --recursive --exclude "*" --include "*maillog-*.gz" 2>&1 /home/ssm-user/rotate.log
/bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true