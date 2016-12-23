#!/bin/bash

#
# INITIALIZE INSECURE
#
mysqld --initialize-insecure
mkdir /var/run/mysqld/
chown -R mysql:mysql /var/run/mysqld/
chown -R mysql:mysql /var/log/mysql/
usermod -d /var/lib/mysql/ mysql

#
# GRANT USER PRIVS IN 10 SECS
#
(\
    echo ">> DOCKER-POST-START: waiting 10 secs for startup to grant privileges ..."; \
    sleep 10; \
    mysql --execute "GRANT ALL PRIVILEGES ON *.* TO ${MYSQL_USER}@'%' IDENTIFIED BY '${MYSQL_PASS}' WITH GRANT OPTION; FLUSH PRIVILEGES;"; \
    echo ">> DOCKER-POST-START: GRANTED PRIVS TO MYSQL USER ${MYSQL_USER}" >> /var/log/mysql/error.log \
) &

#
# START MYSQL IN FOREGROUND
#
mysqld_safe