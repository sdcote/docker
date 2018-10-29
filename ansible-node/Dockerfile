# This starts with the SSHD image and adds python 2.7 so Ansible will be able 
# to configure the node.
#
# The recommended way to run this for a regular node is:
# 
# docker run -d -p :22 --name nodea --hostname nodea node
#
# or if tou want bot the SSH and HTTP ports published:
#
# docker run -d -P --name nodea --hostname nodea node
#

FROM sshd

RUN apt-get update && apt-get install -y python2.7 python-pip && apt-get install -y python3-pip

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# This is how we can put stuff in our environment variables
#ENV NOTVISIBLE "in users profile"
#RUN echo "export VISIBLE=now" >> /etc/profile

# Expose ssh (duh) and also HTTP because web servers are often installed later.
EXPOSE 22 80

CMD ["/usr/sbin/sshd", "-D"]