Docker Debian systemd
--
[![Docker Hub](https://img.shields.io/docker/cloud/build/uridium/debian-systemd.svg)](https://hub.docker.com/r/uridium/debian-systemd/builds)

Debian systemd container to start a service that requires systemd.

### Requirements

* docker
* make

### Installation

To build the container using Debian stable:

    make stable

or Debian stretch:

    make stretch

You can use any tag mentioned [here](https://hub.docker.com/_/debian):

    make <tag>

To download the latest version from the [registry](https://hub.docker.com/r/uridium/debian-systemd/):

    make pull

To [verify](https://github.com/GoogleContainerTools/container-structure-test) the content and structure of the container:

    make test

### Use

This container is especially useful when running [molecule test](https://molecule.readthedocs.io/en/latest/examples.html#systemd-container). For example:

```yaml
---
dependency:
  name: galaxy
driver:
  name: docker
platforms:
  - name: debian-systemd-stable
    image: uridium/debian-systemd:stable
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
    command: /sbin/init
    environment:
      container: docker
    privileged: True
provisioner:
  name: ansible
verifier:
  name: ansible
lint: |
  yamllint .
  ansible-lint
  flake8
```
