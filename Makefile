# Image URL to use all building/pushing image targets
REGISTRY ?= quay.io
REPOSITORY ?= $(REGISTRY)/eformat/docsify-enablement

IMG := $(REPOSITORY):4.6

# Docker Login
podman-login:
	@podman login -u $(DOCKER_USER) -p $(DOCKER_PASSWORD) $(REGISTRY)

# Build the docker image
podman-build:
	podman build . -t ${IMG} -f Dockerfile

# Push the docker image
podman-push: podman-build
	podman push ${IMG}
