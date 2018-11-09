# Ubuntu with Ansible and OpenSSH
#
# The idea is to have a local control node running into which you can SSH and 
# provision other running containers.
#
# docker run -d -P --name <container_name> <image_name>
#
# You can non SSH into the container and use ansible with root:coyote
#
# Consider using volumes for all your local playbooks and inventories so you 
# don't lose data when you remove the container.
#
# docker volume create ansible
# docker run -d -P -v ansible:/opt/ansible --name <container_name> <image_name>
# 
# Next, run one or more containers which are listening to SSH and have python 
# installed.

FROM ubuntu:16.04
MAINTAINER Steve Cote <sdcote@gmail.com>

# Install Ansible
RUN apt-get update && apt-get install -y unzip git software-properties-common && apt-add-repository ppa:ansible/ansible && apt-get update -y && apt-get install ansible -y && ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa

# Install the SSH daemon so we can log into this container and run our playbooks
RUN apt-get install -y openssh-server && mkdir /var/run/sshd && echo 'root:coyote' | chpasswd && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# This also installs Terraform - should probably put this in a separate Dockerfile
RUN wget --quiet https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip && unzip -qq terraform_0.11.10_linux_amd64.zip && mv terraform /usr/local/bin/ && rm terraform_0.11.10_linux_amd64.zip

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
