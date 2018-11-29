#
# The recommended way to run this for a regular node is:
# 
# docker run -d -p :22 --name nodea --hostname nodea node
#
# or if you want both the SSH and HTTP ports published:
#
# docker run -d -P --name nodea --hostname nodea node
#
FROM ubuntu:18.04

# Add the minimal packages for eanle Ansible configuration
RUN apt-get update \
  && apt-get install -y openssh-server iproute2 sudo python2.7 python-pip python3-pip \
  && mkdir /var/run/sshd \
  && echo 'root:coyote' | chpasswd \
  && sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config

# Add a non privileged user with SSH keys that Ansible can use for connections
RUN useradd -m ansible -s /bin/bash \
  && mkdir -p /home/ansible/.ssh
ADD public-key.txt /home/ansible/.ssh/authorized_keys
RUN chown -R ansible /home/ansible/.ssh \
  && chmod 600 /home/ansible/.ssh/authorized_keys \
  && echo "ansible ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/ansible \
  && chmod 0440 /etc/sudoers.d/ansible

# Expose ssh common ports.
EXPOSE 22 80 443

# Run SSH daemon
CMD ["/usr/sbin/sshd", "-D"]