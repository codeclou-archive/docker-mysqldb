FROM ubuntu:16.04

#
# PACKAGES
#
RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/* && \
    sudo apt-get update && \
    sudo apt-get -y install apt-utils wget curl bzip2 build-essential zlib1g-dev git && \
    echo 'mysql-server mysql-server/root_password password __DUMMYPW__' | debconf-set-selections && \
    echo 'mysql-server mysql-server/root_password_again password __DUMMYPW__' | debconf-set-selections && \
    sudo apt-get -y install mysql-server

#
# WORKDIR
#
WORKDIR /var/lib/mysql

EXPOSE 3306

#
# ERROR LOG TO STDOUT
#
RUN ln -sf /dev/stderr /var/log/mysql/error.log

#
# MY.CNF 
#
RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo '\nskip-host-cache\nskip-name-resolve\n' >> /etc/mysql/mysql.conf.d/mysqld.cnf

#
# INIT DATA DIR (if not empty) AND START MYSQL
#
ENV MYSQL_USER dbadmin
ENV MYSQL_PASS dbadmin
COPY run.sh /opt/run.sh
RUN chmod +x /opt/run.sh

#
# RUN
#
CMD ["/opt/run.sh"]
