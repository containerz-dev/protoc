# syntax=docker.io/docker/dockerfile:1.4.0-labs

ARG BUILDKIT_VERSION
ARG DOCKER_VERSION

FROM --platform=$BUILDPLATFORM docker:${DOCKER_VERSION} AS docker

FROM --platform=$BUILDPLATFORM moby/buildkit:${BUILDKIT_VERSION} AS buildkit
COPY --from=docker /usr/local/bin/docker /usr/local/bin/docker
