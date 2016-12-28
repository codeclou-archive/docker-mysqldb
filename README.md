# docker-mysqldb

Dockerized MysqlDB for testing. Should not be used in production. 

![](https://codeclou.github.io/doc/docker-warranty.svg?v5)

-----

### Usage

Start on Port `3366` with user `dbadmin` and password `dbadmin` and mysql-data dir in `./mysql-data/`.

```bash
docker run  \
    --name dblocal.codeclou.io \
    -p 3366:3306 \
    -v $(pwd)/mysql-data:/var/lib/mysql \
    codeclou/docker-mysqldb:latest
```

Start with custom mysql username and password 

```bash
docker run \
    --name dblocal.codeclou.io \
    -e MYSQL_USER='steve' \
    -e MYSQL_PASS='foo' 
    -p 3366:3306 \
    -v $(pwd)/mysql-data:/var/lib/mysql \
    codeclou/docker-mysqldb:latest
```

-----

### License

  * Dockerfile and Image is provided under [MIT License](https://github.com/codeclou/docker-mysqldb/blob/master/LICENSE.md)
