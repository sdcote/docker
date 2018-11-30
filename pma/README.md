# phpMyAdmin

Run phpMyAdmin with Alpine, supervisor, nginx and PHP FPM.

## Build

Call docker build with an appropriate build tag:

```
docker build -t pma .
```

All following examples will bring you phpMyAdmin on `http://localhost:8080` where you can enjoy your happy MySQL administration.

## Usage with external server

You can specify MySQL host in the `PMA_HOST` environment variable. You can also use `PMA_PORT` to specify port of the server in case it's not the default one:

```
docker run --name myadmin -d -e PMA_HOST=dbhost -p 8080:80 pma
```

## Usage with arbitrary server

You can use arbitrary servers by adding ENV variable `PMA_ARBITRARY=1` to the startup command:

```
docker run --name myadmin -d -e PMA_ARBITRARY=1 -p 8080:80 pma
```

## Adding Custom Configuration

You can add your own custom config.inc.php settings (such as Configuration Storage setup) by creating a file named "config.user.inc.php" with the various user defined settings in it, and then linking it into the container using:

```
-v /some/local/directory/config.user.inc.php:/etc/phpmyadmin/config.user.inc.php
```
On the "docker run" line like this:
``` 
docker run --name myadmin -d --link mysql_db_server:db -p 8080:80 -v /some/local/directory/config.user.inc.php:/etc/phpmyadmin/config.user.inc.php pma
```

See the following links for config file information.
https://docs.phpmyadmin.net/en/latest/config.html#config
https://docs.phpmyadmin.net/en/latest/setup.html

## Usage behind reverse proxys

Set the variable ``PMA_ABSOLUTE_URI`` to the fully-qualified path (``https://pma.example.net/``) where the reverse proxy makes phpMyAdmin available.

## Environment variables summary

* ``PMA_ARBITRARY`` - when set to 1 connection to the arbitrary server will be allowed
* ``PMA_HOST`` - define address/host name of the MySQL server
* ``PMA_VERBOSE`` - define verbose name of the MySQL server
* ``PMA_PORT`` - define port of the MySQL server
* ``PMA_HOSTS`` - define comma separated list of address/host names of the MySQL servers
* ``PMA_VERBOSES`` - define comma separated list of verbose names of the MySQL servers
* ``PMA_PORTS`` -  define comma separated list of ports of the MySQL servers
* ``PMA_USER`` and ``PMA_PASSWORD`` - define username to use for config authentication method
* ``PMA_ABSOLUTE_URI`` - define user-facing URI

