REPO = uridium/debian-systemd

stable buster 10: TAG = -t $(REPO):latest

default: stable

pull:
	docker pull $(REPO)

.DEFAULT:
	docker build --build-arg DIST=$@ -t $(REPO):$@ ${TAG} .

run:
	docker run -d --rm --privileged --name debian-systemd -v /sys/fs/cgroup:/sys/fs/cgroup:ro $(REPO)

clean:
	docker rmi $(shell docker images $(REPO) -qa)
