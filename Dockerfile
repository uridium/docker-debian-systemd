ARG DIST="stable"

FROM debian:$DIST

ENV DEBIAN_FRONTEND="noninteractive" \
    LC_ALL="C"

RUN apt-get update -qq \
    && apt-get dist-upgrade -y -qq \
    && apt-get install --no-install-recommends -y \
        systemd \
        python3 \
        procps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

RUN rm -f \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/multi-user.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
    /lib/systemd/system/systemd-update-utmp* \
    && ln -s /lib/systemd/system /sbin/init \
    && systemctl set-default multi-user.target

VOLUME ["/sys/fs/cgroup"]

ENTRYPOINT ["/lib/systemd/systemd"]
