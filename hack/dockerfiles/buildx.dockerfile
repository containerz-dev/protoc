# syntax=docker/dockerfile:1.3

ARG DOCKER_VERSION
ARG BUILDX_VERSION
ARG BUILDKIT_VERSION

FROM --platform=$BUILDPLATFORM docker/buildx-bin:${BUILDX_VERSION} AS buildx

FROM --platform=$BUILDPLATFORM moby/buildkit:${BUILDKIT_VERSION} as buildkit

FROM --platform=$BUILDPLATFORM docker:${DOCKER_VERSION} AS docker
COPY --from=buildx /buildx /usr/libexec/docker/cli-plugins/docker-buildx
COPY --from=buildkit /usr/bin/buildctl /usr/bin/buildctl
RUN docker buildx version
