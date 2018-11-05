FROM alpine:3.8
LABEL maintainer "Steve Cote - https://github.com/sdcote"

RUN apk add --no-cache openssh apache2-proxy php7-fpm \
  && rm /etc/init.d/sshd \
  && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
  && echo "root:coyote" | chpasswd 

COPY root /

EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]
