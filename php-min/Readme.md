# php-min

This is a very small Alpine Linux distribution which contains an Apache2 PHP-FPM installation and listens to SSH connections.

The entry point for the image is a simple script which scans through `/etc/init.d/` for scripts and runs them before calling SSHD. The result is SSHD running in PID 1 and potentially other processes in the background.

Running scripts in the `/etc/init.d/` directory is intended as a way to setup the host environment, not to run business logic components.

# init.d Scripts

The scripts in `/etc/init.d/` will be called with the "start" argument to make the initialization more compatible with popular scripts. Installing packages normally places initialization scripts in this directory so they should be started as expected.

See https://wiki.alpinelinux.org/wiki/Apache_with_php-fpm for more information.