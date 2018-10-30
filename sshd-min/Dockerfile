FROM alpine:3.8
LABEL maintainer "Steve Cote - https://github.com/sdcote"
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 22
COPY root /

RUN apk add --no-cache openssh \
  && rm /etc/init.d/sshd \
  && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
  && echo "root:coyote" | chpasswd