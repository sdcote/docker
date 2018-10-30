# ssh-min

This is a very small Alpine Linux distribution which  listens to SSH connections. Its purpose is to provide a simple server which accepts SSH connections. It can be used as a base image onto which other background process can be installed.

The entry point for the image is a simple script which scans through `/etc/init.d/` for scripts and runs them before calling SSHD. The result is SSHD running in PID 1 and potentially other processes in the background. The container will remain running on the host system

This provides a simple platform for running background processes in a container while allowing SSH connections for debugging and configuration.

While some will argue this goes against the design of containers as a single process construct, this approach provides some unique possibilities during development and testing. First and foremost is the ability to have a simple jump host into the container environment.

Running scripts in the `/etc/init.d/` directory is intended as a way to setup the host environment, not to run business logic components.

# init.d Scripts

The scripts in `/etc/init.d/` will be called with the "start" argument to make the initialization more compatible with popular scripts. Installing packages normally places initialization scripts in this directory so they should be started as expected.

The background processes are only started. No lifecycle management is provided. When the container is stopped, the processes are terminated without signals. If this is not desired, `initd` or an equivalent should be installed in the image to gracefully start and stop background processes. Again, this generally goes against container design principles and is not recommended.