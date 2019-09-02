# docker-mysqldb

## :bangbang: Deprecated and Discontinued :bangbang:

[![](https://codeclou.github.io/doc/badges/generated/docker-image-size-52.svg)](https://hub.docker.com/r/codeclou/docker-mysqldb/tags/) [![](https://codeclou.github.io/doc/badges/generated/docker-from-alpine-3.5.svg)](https://alpinelinux.org/) [![](https://codeclou.github.io/doc/badges/generated/docker-run-as-non-root.svg)](https://docs.docker.com/engine/reference/builder/#/user)

[MariaDB](https://mariadb.org/) Docker-Image for local testing and development.


-----
&nbsp;

### Prerequisites

 * Runs as non-root with fixed UID 10777 and GID 10777. See [howto prepare volume permissions](https://github.com/codeclou/doc/blob/master/docker/README.md).
 * See [howto use SystemD for named Docker-Containers and system startup](https://github.com/codeclou/doc/blob/master/docker/README.md).



-----
&nbsp;



### Usage

Start on Port `3366` with user `dbadmin` and password `dbadmin` and mysql-data dir in `./mysql-data/`.


```bash
docker run \
     -i -t \
     -p 3366:3306 \
     -v $(pwd)/mysql-data:/var/lib/mysql \
     codeclou/docker-mysqldb:latest
```

Start with custom mysql username and password 

```bash
docker run \
     -i -t \
     -p 3366:3306 \
     -e MYSQL_USER='steve' \
     -e MYSQL_PASS='foo' \
     -v $(pwd)/mysql-data:/var/lib/mysql \
     codeclou/docker-mysqldb:latest
```

Note:

 * The `mysql`-Database containing Users is only copied into mysql-data dir on each start if it does not exist.
 * That means you need to delete it if you want to start the server with a different MYSQL_USER and MYSQL_PASSWORD.

&nbsp;

If you need to access the **error.log** use this command and replace ID with your containers ID.

```
docker exec -i -t 6f7c0c747260 cat /var/log/mysql/error.log
```

-----
&nbsp;

### License, Liability & Support

 * [![](https://codeclou.github.io/doc/docker-warranty-notice.svg?v1)](https://github.com/codeclou/docker-mysqldb/blob/master/LICENSE.md)
 * Dockerfile and Image is provided under [MIT License](https://github.com/codeclou/docker-mysqldb/blob/master/LICENSE.md)
