REPO = uridium/debian-systemd

stable buster 10: TAG = -t $(REPO):latest

default: stable

pull:
	docker pull $(REPO)

.DEFAULT:
	docker build --build-arg DIST=$@ -t $(REPO):$@ ${TAG} .

run:
	docker run -d --rm --privileged --name debian-systemd -v /sys/fs/cgroup:/sys/fs/cgroup:ro $(REPO)

test:
	docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v $(shell pwd)/tests.yml:/tests.yml gcr.io/gcp-runtimes/container-structure-test test -i $(REPO) -c tests.yml

clean:
	docker rmi $(shell docker images $(REPO) -qa)
