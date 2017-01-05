FROM alpine:3.5

#
# PACKAGES
#
RUN apk add --no-cache \
            bash \
            shadow \
            pwgen \
            mariadb \
            mariadb-client

#
# CHANGING UID AND GID OF MARIADB PRE-INSTALL CREATED USERS TO FIXED VALUE 10777
# SEE: http://git.alpinelinux.org/cgit/aports/tree/main/mariadb/mariadb.pre-install
#
RUN usermod -u 10777 mysql && \
    groupmod -g 10777 mysql && \
    id mysql && \
    mkdir -p /var/log/mysql/ && \
    touch /var/log/mysql/error.log && \
    mkdir -p /run/mysqld/ && \
    mkdir -p /opt/mysql/ && \
    chown -R mysql:mysql /run/mysqld/ && \
    chown -R mysql:mysql /opt/mysql/ && \
    chown -R mysql:mysql /var/log/mysql/ && \
    /usr/bin/mysql_install_db --user=mysql && \
    cp -arv /var/lib/mysql/mysql /opt/mysql/mysql-after-init



#
# MY.CNF
#
RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/my.cnf && \
    echo '\nskip-host-cache\nskip-name-resolve\nlog-error="/var/log/mysql/error.log"\n' >> /etc/mysql/my.cnf

#
# RUN SCRIPT
#
COPY docker-entrypoint.sh /opt/docker-entrypoint.sh
RUN chmod u+rx,g+rx,o+rx,a-w /opt/docker-entrypoint.sh

#
# RUN
#
EXPOSE 3306
USER mysql
ENV MYSQL_USER dbadmin
ENV MYSQL_PASS dbadmin
WORKDIR /var/lib/mysql
ENTRYPOINT ["/opt/docker-entrypoint.sh"]
CMD ["mysqld_safe"]