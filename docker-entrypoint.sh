#!/bin/bash

set -e

#
# SINCE MYSQLD DOES NOT REACT TO CTRL+C
# BUT INSTEAD TO SIGTERM WE NEED TO USE THIS APPROACH
# SEE: https://github.com/docker-library/mysql/issues/47
#
function exec_sigterm_aware() {
    exec "$@" &
    pid="$!"
    trap "kill -SIGQUIT $pid" INT
    wait
}

#
# START
#
if [ "$1" = 'mysqld_safe' ]
then
    if [ ! -d "/var/lib/mysql/mysql" ]
    then
        echo ">> DOCKER-ENTRYPOINT: NO MYSQL DB DIR FOUND. COPYING DEFAULT ONE AND CREATING USERS ..."
        mv /opt/mysql/mysql-after-init /var/lib/mysql/mysql
        (\
            echo ">> DOCKER-ENTRYPOINT: waiting 2 secs for mysql startup to grant privileges ..." && \
            sleep 2 &&\
            /usr/bin/mysql -uroot --execute "GRANT ALL PRIVILEGES ON *.* TO ${MYSQL_USER}@'%' IDENTIFIED BY '${MYSQL_PASS}' WITH GRANT OPTION; FLUSH PRIVILEGES;" && \
            RANDOMPW=$(pwgen --secure 256 1) && \
            /usr/bin/mysqladmin -u root password "$RANDOMPW" && \
            echo ">> DOCKER-ENTRYPOINT: GRANTED PRIVS TO MYSQL USER ${MYSQL_USER}"
        ) &
    else
        echo ">> DOCKER-ENTRYPOINT: MYSQL DB DIR FOUND. NOT CREATING USERS ..."
    fi
    exec_sigterm_aware /usr/bin/mysqld_safe \
                            --datadir='/var/lib/mysql' \
                            --log-error='/var/log/mysql/error.log'
else
    echo ">> DOCKER-ENTRYPOINT: NO OTHER COMMAND ALLOWED. EXIT!"
    exit 1
fi