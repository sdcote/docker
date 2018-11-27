#
# The recommended way to run this for a regular node is:
# 
# docker run -d -p :22 --name nodea --hostname nodea node
#
# or if you want both the SSH and HTTP ports published:
#
# docker run -d -P --name nodea --hostname nodea node
#

FROM ubuntu:16.04

RUN apt-get update \
  && apt-get install -y openssh-server iproute2 python2.7 python-pip \
  && mkdir /var/run/sshd \
  && echo 'root:coyote' | chpasswd \
  && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
  && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
  && apt-get install -y python3-pip

# Expose ssh common ports.
EXPOSE 22 80 443

# Run SSH daemon
CMD ["/usr/sbin/sshd", "-D"]