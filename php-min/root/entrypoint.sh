#!/bin/ash

# generate host keys if not present
ssh-keygen -A


for script in /etc/init.d/* ; do
  if [ -r $script ] && [ -x $script ]; then
    echo "Running $(basename ${script})"
    $script start
    if [ $? -ne 0 ]; then
      echo "FATAL: Failed to initialize"
      exit 1
    fi
  fi
done

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"