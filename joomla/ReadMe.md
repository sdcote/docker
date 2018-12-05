# What is Joomla?
Joomla is a free and open-source content management system (CMS) for publishing web content. It is built on a model–view–controller web application framework that can be used independently of the CMS. Joomla is written in PHP, uses object-oriented programming (OOP) techniques and software design patterns, stores data in a MySQL, MS SQL, or PostgreSQL database, and includes features such as page caching, RSS feeds, printable versions of pages, news flashes, blogs, search, and support for language internationalization.

## How Is This Image Different?
This container is different from the official Joomla images in that it also contain SSH services to make it easy to SCP files to the containers and SSH into them. During development, the use of a terminal and secure file transfer tools greatly enhance productivity.

# Building the Image
Just like any other image:
```
docker build -t joomla .
```


# How To Use This Image
You can link this to a container running a MySQL database:
```
$ docker run --name joomla --link some-mysql:mysql -d joomla
```

The following environment variables are also honored for configuring your Joomla instance:

* `-e JOOMLA_DB_HOST=...` (defaults to the IP and port of the linked mysql container)
* `-e JOOMLA_DB_USER=...` (defaults to "root")
* `-e JOOMLA_DB_PASSWORD=...` (defaults to the value of the `MYSQL_ROOT_PASSWORD` environment variable from the linked mysql container)
* `-e JOOMLA_DB_NAME=...` (defaults to "joomla")
* `-e SSH_PASSWORD=...` (defaults to "coyote")

If the `JOOMLA_DB_NAME` specified does not already exist on the given MySQL server, it will be created automatically upon startup of the joomla container, provided that the `JOOMLA_DB_USER` specified has the necessary permissions to create it.

If you'd like to be able to access the instance from the host without the container's IP, standard port mappings can be used:
```
$ docker run --name some-joomla --link some-mysql:mysql -p 8080:80 -d joomla
```

Then, access it via http://localhost:8080 or http://host-ip:8080 in a browser.

## Use An External Database
If you'd like to use an external database instead of a linked mysql container, specify the hostname and port with `JOOMLA_DB_HOST` along with the password in `JOOMLA_DB_PASSWORD` and the username in `JOOMLA_DB_USER` (if it is something other than root):
```
$ docker run --name joomla -e JOOMLA_DB_HOST=10.1.2.3:3306 -e JOOMLA_DB_USER=... -e JOOMLA_DB_PASSWORD=... -d joomla
```

### Complete External Database Scenario
As an example, if you ran the following to start a mysql server:
```
$ docker run --restart unless-stopped --name=mysql -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=coyote -e MYSQL_ROOT_HOST=% mysql/mysql-server:5.7
```
You will have a mysql container running on the local machine listening to port 3306. To find out the IP address allocated to the container, you can type the following:
```
$ docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql 
172.17.0.2
$
```
The above shows `172.17.0.2` as the IP address of the MySQL server
You now know the IP address and port for the database server and since you defined the password, you can now connect to that database with root:coyote to access the MySQL instance. Your Joomla instance can now be called with the following:
```
$ docker run -d --name joomla -p :22 -p 80:80 -p 443:443 -e JOOMLA_DB_HOST=172.17.0.2:3306 -e JOOMLA_DB_PASSWORD=coyote joomla
```
The above defines the database host as `172.17.0.3:3306` and will create a "joomla" database using the `root` user (the default) ad a password of `coyote`. The ports are mapped with SSH being mapped to a random port and HTTP being mapped directly.

Once the container is running, you can point your browser to http://localhost and finish the final Joomla! configuration via the web pages. Page 2 contains the database details. On this page you would place the IP address of the mysql container (172.17.0.2 in the above example) the user name of `root` (the default mysql username) and a password of `coyote` as specified on the command line to run the mysql database. The database name is `joomla` which is the default database created by the Joomla container when it was run.

You can also SCP and SSH into the host on whatever port the docker runtime has mapped to the joomla container instance. Typing `docker ps` will give you that information.

## Running Via Docker Stack or Compose
Example `stack.yml` for joomla:
```
version: '3.1'

services:
  joomla:
    image: joomla
    restart: always
    links:
      - joomladb:mysql
    ports:
      - 8080:80
    environment:
      JOOMLA_DB_HOST: joomladb
      JOOMLA_DB_PASSWORD: example

  joomladb:
    image: mysql:5.7
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: example
```

Run `docker stack deploy -c stack.yml joomla`. For Docker Compose run `docker-compose -f stack.yml up'.

In either case, wait for the Joomla container to initialize completely, then visit http://swarm-ip:8080, http://localhost:8080, or http://host-ip:8080 as appropriate.


