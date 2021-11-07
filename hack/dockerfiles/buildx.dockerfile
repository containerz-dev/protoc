# syntax=docker/dockerfile:1.3

ARG DOCKER_VERSION
ARG BUILDX_VERSION

FROM --platform=$BUILDPLATFORM docker/buildx-bin:${BUILDX_VERSION} AS buildx

FROM --platform=$BUILDPLATFORM docker:${DOCKER_VERSION} AS docker
COPY --from=buildx /buildx /usr/libexec/docker/cli-plugins/docker-buildx
RUN docker buildx version
