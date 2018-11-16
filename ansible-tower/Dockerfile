FROM ubuntu:14.04.5
LABEL maintainer "Steve Cote - https://github.com/sdcote"

WORKDIR /opt

# Check https://releases.ansible.com/ansible-tower/setup/ for the version to retrieve 
ENV ANSIBLE_TOWER_VER 3.2.8
ENV PG_DATA /var/lib/postgresql/9.6/main
ENV CERTS /certs
ENV AWX_PROJECTS /var/lib/awx/projects

# SSHD setup
RUN apt-get update \
  && apt-get install -y openssh-server iproute2 \
  && mkdir /var/run/sshd \
  && echo 'root:coyote' | chpasswd \
  && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
  && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Python setup
RUN apt-get update \
  && apt-get install -y software-properties-common \
  && apt-add-repository -y ppa:fkrull/deadsnakes-python2.7 \
	&& apt-key adv --keyserver keyserver.ubuntu.com --recv 5BB92C09DB82666C \
	&& apt-get update \
  && locale-gen "en_US.UTF-8" \
	&& export LC_ALL="en_US.UTF-8" \
	&& dpkg-reconfigure locales \
	&& apt-get install -y libpython2.7 apt-transport-https ca-certificates

# Create /var/log/tower
RUN mkdir -p /var/log/tower

# Download & extract Tower tarball
ADD http://releases.ansible.com/ansible-tower/setup/ansible-tower-setup-${ANSIBLE_TOWER_VER}.tar.gz ansible-tower-setup-${ANSIBLE_TOWER_VER}.tar.gz
RUN tar xvf ansible-tower-setup-${ANSIBLE_TOWER_VER}.tar.gz \
    && rm -f ansible-tower-setup-${ANSIBLE_TOWER_VER}.tar.gz

WORKDIR /opt/ansible-tower-setup-${ANSIBLE_TOWER_VER}
ADD inventory inventory

# Tower setup - this calls an Ansible playbook to configure itself
RUN ./setup.sh

# Docker entrypoint script and any other files
COPY root /
RUN chmod +x /docker-entrypoint.sh

# Volumes and ports
VOLUME ["${PG_DATA}", "${AWX_PROJECTS}", "${CERTS}",]
EXPOSE 22 443

CMD ["/docker-entrypoint.sh", "ansible-tower"]
