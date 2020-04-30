ARG DIST="stable"

FROM debian:$DIST

ENV DEBIAN_FRONTEND="noninteractive" \
    LC_ALL="C" \
    container="docker"

RUN apt-get update -qq \
    && apt-get dist-upgrade -y -qq \
    && apt-get install -y \
        systemd \
        systemd-sysv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

RUN rm -f \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/multi-user.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
    /lib/systemd/system/systemd-update-utmp*

VOLUME ["/sys/fs/cgroup"]

CMD ["/lib/systemd/systemd"]
