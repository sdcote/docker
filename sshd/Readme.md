

Build the image using:
```
$ docker build -t sshd .
```

# Run a test_sshd container

Then run it. You can then use docker port to find out what host port the container’s port 22 is mapped to:
```
$ docker run -d -P --name test_host sshd
$ docker port test_sshd 22

0.0.0.0:49154
```
And now you can ssh as root on the container’s IP address (you can find it with docker inspect) or on port 49154 of the Docker daemon’s host IP address (ip address or ifconfig can tell you that) or localhost if on the Docker daemon host:
```
$ ssh root@192.168.1.2 -p 49154
# The password is ``coyote``.
root@f38c87f2a42d:/#
```

It may be easier to publish the port on a known port:
```
$ docker run -d -p 22:22 --name test_host sshd
```
Then you can SSH to `localhost`:
```
$ ssh root@localhost
```

Although this may not be possible if you already have `sshd` running on your local host.

# Environment variables

Using the `sshd` daemon to spawn shells makes it complicated to pass environment variables to the user’s shell via the normal Docker mechanisms, as `sshd` scrubs the environment before it starts the shell.

If you’re setting values in the `Dockerfile` using `ENV`, you need to push them to a shell initialization file like the `/etc/profile` example in the `Dockerfile` of this project.

If you need to pass `docker run -e ENV=value` values, you need to write a short script to do the same before you start `sshd -D` and then replace the `CMD` with that script.

# Clean up

Finally, clean up after your test by stopping and removing the container, and then removing the image.
```
$ docker container stop test_host
$ docker container rm test_host
$ docker image rm sshd
```