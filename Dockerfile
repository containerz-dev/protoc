# syntax = docker.io/docker/dockerfile-upstream:master-experimental

ARG GOLANG_VERSION
ARG ALPINE_VERSION

# target: protoc-builder
FROM docker.io/debian:buster-slim AS protoc-builder
ENV DEBIAN_FRONTEND=noninteractive
ARG PROTOC_VERSION
RUN set -eux && \
	apt-get -qy update && \
	apt-get -qy --no-install-recommends install \
		ca-certificates \
		unzip \
		wget
RUN set -eux && \
	wget -q https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip && \
	unzip protoc-${PROTOC_VERSION}-linux-x86_64.zip -d protoc && \
	rm protoc-${PROTOC_VERSION}-linux-x86_64.zip

# target: protoc
FROM gcr.io/distroless/base:nonroot AS protoc
COPY --from=protoc-builder --chown=nonroot:nonroot /protoc/bin/ /usr/local/bin/
COPY --from=protoc-builder --chown=nonroot:nonroot /protoc/include/google/ /usr/local/include/google
USER nonroot:nonroot
LABEL maintainer="The containerz Authors" \
      org.opencontainers.image.title="gcr.io/containerz/protoc/protoc" \
      org.opencontainers.image.description="protoc container image" \
      org.opencontainers.image.url="https://github.com/containerz-dev/protoc" \
      org.opencontainers.image.source="git@github.com:containerz-dev/protoc" 
ENTRYPOINT ["protoc", "-I/usr/local/include"]

# target: protoc-debug
FROM gcr.io/distroless/base:debug-nonroot AS protoc-debug
COPY --from=protoc-builder --chown=nonroot:nonroot /protoc/bin/ /usr/local/bin/
COPY --from=protoc-builder --chown=nonroot:nonroot /protoc/include/google/ /usr/local/include/google
USER nonroot:nonroot
LABEL maintainer="The containerz Authors" \
      org.opencontainers.image.title="gcr.io/containerz/protoc/protoc:debug" \
      org.opencontainers.image.description="protoc container image" \
      org.opencontainers.image.url="https://github.com/containerz-dev/protoc" \
      org.opencontainers.image.source="git@github.com:containerz-dev/protoc" 
ENTRYPOINT ["protoc", "-I/usr/local/include"]

# target: golang-builder
FROM docker.io/golang:${GOLANG_VERSION}-alpine${ALPINE_VERSION} AS golang-builder
ENV \
	OUTDIR=/out \
	CGO_ENABLED=0 \
	GO111MODULE=on
RUN set -eux && \
	apk --no-cache add \
		git
ARG PROTOC_GEN_GO_VERSION
ARG PROTOC_GEN_GO_GRPC_VERSION
RUN set -eux && \
	GOBIN="${OUTDIR}/usr/local/bin" go get -a -u -v -tags='osusergo,netgo,static' -gcflags="all=-trimpath=${GOPATH}" -ldflags="-d -s -w '-extldflags=-static'" -asmflags="all=-trimpath=${GOPATH}" -installsuffix='netgo' \
		google.golang.org/protobuf/cmd/protoc-gen-go@${PROTOC_GEN_GO_VERSION} \
		google.golang.org/grpc/cmd/protoc-gen-go-grpc@${PROTOC_GEN_GO_GRPC_VERSION}

# target: golang
FROM gcr.io/distroless/base:nonroot AS golang
COPY --from=golang-builder --chown=nonroot:nonroot /out/ /
COPY --from=protoc --chown=nonroot:nonroot /usr/local/bin/protoc /usr/local/bin/protoc
COPY --from=protoc --chown=nonroot:nonroot /usr/local/include /usr/local/include/
USER nonroot:nonroot
LABEL maintainer="The containerz Authors" \
      org.opencontainers.image.title="gcr.io/containerz/protoc/golang" \
      org.opencontainers.image.description="protoc and protoc-gen-go related binaries container image" \
      org.opencontainers.image.url="https://github.com/containerz-dev/protoc" \
      org.opencontainers.image.source="git@github.com:containerz-dev/protoc" 
ENTRYPOINT ["protoc", "-I/usr/local/include"]

# target: golang-debug
FROM gcr.io/distroless/base:debug-nonroot AS golang-debug
COPY --from=golang-builder --chown=nonroot:nonroot /out/ /
COPY --from=protoc-debug --chown=nonroot:nonroot /usr/local/bin/protoc /usr/local/bin/protoc
COPY --from=protoc-debug --chown=nonroot:nonroot /usr/local/include /usr/local/include/
USER nonroot:nonroot
LABEL maintainer="The containerz Authors" \
      org.opencontainers.image.title="gcr.io/containerz/protoc/golang:debug" \
      org.opencontainers.image.description="protoc and protoc-gen-go related binaries container image" \
      org.opencontainers.image.url="https://github.com/containerz-dev/protoc" \
      org.opencontainers.image.source="git@github.com:containerz-dev/protoc" 
ENTRYPOINT ["protoc", "-I/usr/local/include"]
