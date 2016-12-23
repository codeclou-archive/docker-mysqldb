# docker-mysqldb

Dockerized MysqlDB for testing. 

:bangbang: **NOTE: This image should only be used during development.** You might want to use the official images instead.

### Usage

Start on Port `3366` with user `dbadmin` and password `dbadmin` and mysql-data dir in `./mysql-data/`.

```bash
docker run  -p 3366:3306 -v $(pwd)/mysql-data:/var/lib/mysql --name dblocal.codeclou.io codeclou/docker-mysqldb:latest
```

Start with custom mysql username and password 

```bash
docker run -e MYSQL_USER='steve' -e MYSQL_PASS='foo'  -p 3366:3306 -v $(pwd)/mysql-data:/var/lib/mysql --name dblocal.codeclou.io codeclou/docker-mysqldb:latest
```


### License

  * Dockerfile and Image is provided under [MIT License](https://github.com/codeclou/docker-mysqldb/blob/master/LICENSE.md)
