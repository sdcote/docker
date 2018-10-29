# This is a simple way to get a docker image to listen for SSH connections.
# The goal is to get a clean unix playground each time similar to a VM, only 
# much quicker.
#
# NOTE: This SSH node only works with Ubuntu 16.04
#
# docker run -d -P --name <container_name> <image_name>
#
# You can then ssh into the container just like any other host.
#
FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openssh-server && apt-get install -y iproute2 && mkdir /var/run/sshd && echo 'root:coyote' | chpasswd && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# This is how we can put stuff in our environment variables
#ENV NOTVISIBLE "in users profile"
#RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22 

CMD ["/usr/sbin/sshd", "-D"]