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
FROM gcr.io/distroless/static:nonroot AS protoc
COPY --from=protoc-builder --chown=nonroot:nonroot /protoc/ /usr/local/
LABEL maintainer="The containerz Authors" \
      org.opencontainers.image.title="containerz/protoc/protoc" \
      org.opencontainers.image.description="protoc container image" \
      org.opencontainers.image.url="https://github.com/containerz-dev/protoc" \
      org.opencontainers.image.source="git@github.com:containerz-dev/protoc" 
ENTRYPOINT ["protoc"]

# target: protoc-debug
FROM gcr.io/distroless/base:debug-nonroot AS protoc-debug
COPY --from=protoc-builder --chown=nonroot:nonroot /protoc/ /usr/local/
LABEL maintainer="The containerz Authors" \
      org.opencontainers.image.title="containerz/protoc/protoc" \
      org.opencontainers.image.description="protoc container image" \
      org.opencontainers.image.url="https://github.com/containerz-dev/protoc" \
      org.opencontainers.image.source="git@github.com:containerz-dev/protoc" 
ENTRYPOINT ["protoc"]

# target: golang-builder
FROM docker.io/golang:${GOLANG_VERSION}-alpine${ALPINE_VERSION} AS golang-builder
ENV \
	OUTDIR=/out \
	CGO_ENABLED=0 \
	GO111MODULE=on
RUN set -eux && \
	apk --no-cache add \
		git
ARG GO_PROTOC_GEN_PACKAGES
RUN set -eux && \
	GOBIN="${OUTDIR}/usr/local/bin" go get -u -v -tags='osusergo,netgo,static' -installsuffix='netgo' -gcflags="all=-trimpath=${GOPATH}" -ldflags="-d -s -w '-extldflags=-static -fno-PIC'" -asmflags="all=-trimpath=${GOPATH}" ${GO_PROTOC_GEN_PACKAGES}

# target: golang
FROM gcr.io/distroless/static:nonroot AS golang
COPY --from=protoc-builder --chown=nonroot:nonroot /protoc/ /usr/local/
COPY --from=golang-builder --chown=nonroot:nonroot /out/ /
LABEL maintainer="The containerz Authors" \
      org.opencontainers.image.title="containerz/protoc/golang" \
      org.opencontainers.image.description="protoc with protoc-gen-go related binaries container image" \
      org.opencontainers.image.url="https://github.com/containerz-dev/protoc" \
      org.opencontainers.image.source="git@github.com:containerz-dev/protoc" 
ENTRYPOINT ["protoc"]

# target: golang-debug
FROM gcr.io/distroless/base:debug-nonroot AS golang-debug
COPY --from=protoc-builder --chown=nonroot:nonroot /protoc/ /usr/local/
COPY --from=golang-builder --chown=nonroot:nonroot /out/ /
LABEL maintainer="The containerz Authors" \
      org.opencontainers.image.title="containerz/protoc/golang" \
      org.opencontainers.image.description="protoc with protoc-gen-go related binaries container image" \
      org.opencontainers.image.url="https://github.com/containerz-dev/protoc" \
      org.opencontainers.image.source="git@github.com:containerz-dev/protoc" 
ENTRYPOINT ["protoc"]
