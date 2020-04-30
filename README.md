Docker Debian systemd
--

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

### Use

This container is especially useful when running [molecule test](https://molecule.readthedocs.io/en/latest/examples.html#systemd-container). For example:

```yaml
---
dependency:
  name: galaxy
driver:
  name: docker
platforms:
  - name: molecule-debian-stable
    image: uridium/debian-systemd:stable
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
provisioner:
  name: ansible
verifier:
  name: ansible
lint: |
  set -e
  yamllint .
  ansible-lint
  flake8
```
