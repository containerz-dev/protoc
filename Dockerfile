# syntax=docker/dockerfile:1.3

ARG GOLANG_VERSION
ARG ALPINE_VERSION

FROM debian:bullseye-slim AS protoc-builder
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

FROM gcr.io/distroless/base:nonroot AS protoc
COPY --from=protoc-builder --chown=nonroot:nonroot /protoc/bin/protoc /
COPY --from=protoc-builder --chown=nonroot:nonroot /protoc/include/google/ /usr/local/include/google
USER nonroot:nonroot
LABEL maintainer="The containerz Authors" \
	org.opencontainers.image.title="gcr.io/containerz/protoc/protoc" \
	org.opencontainers.image.description="protoc container image" \
	org.opencontainers.image.url="https://github.com/containerz-dev/protoc" \
	org.opencontainers.image.source="git@github.com:containerz-dev/protoc" 
ENTRYPOINT ["/protoc"]

FROM gcr.io/distroless/base:debug-nonroot AS protoc-debug
COPY --from=protoc-builder --chown=nonroot:nonroot /protoc/bin/protoc /
COPY --from=protoc-builder --chown=nonroot:nonroot /protoc/include/google/ /usr/local/include/google
USER nonroot:nonroot
LABEL maintainer="The containerz Authors" \
	org.opencontainers.image.title="gcr.io/containerz/protoc/protoc:debug" \
	org.opencontainers.image.description="protoc container image" \
	org.opencontainers.image.url="https://github.com/containerz-dev/protoc" \
	org.opencontainers.image.source="git@github.com:containerz-dev/protoc" 
ENTRYPOINT ["/protoc"]

FROM golang:${GOLANG_VERSION}-alpine${ALPINE_VERSION} AS golang-builder
ENV \
	OUTDIR=/out \
	CGO_ENABLED=0 \
	GO111MODULE=on
RUN set -eux && \
	apk add --no-cache \
		binutils \
		gcc \
		git \
		libc-dev \
		musl-dev
ARG PROTOC_GEN_GO_VERSION
RUN --mount=type=cache,target=/go/pkg/mod --mount=type=cache,target=/root/.cache \
	set -eux && \
	GOBIN="${OUTDIR}/usr/local/bin" go install -v -tags='osusergo,netgo,static,static_build' -buildmode=pie -ldflags='-s -w -d -linkmode external -buildid= "-extldflags=-static-pie"' -installsuffix='netgo' \
		google.golang.org/protobuf/cmd/protoc-gen-go@${PROTOC_GEN_GO_VERSION}
ARG PROTOC_GEN_GO_GRPC_VERSION
RUN --mount=type=cache,target=/go/pkg/mod --mount=type=cache,target=/root/.cache \
	set -eux && \
	GOBIN="${OUTDIR}/usr/local/bin" go install -v -tags='osusergo,netgo,static,static_build' -buildmode=pie -ldflags='-s -w -d -linkmode external -buildid= "-extldflags=-static-pie"' -installsuffix='netgo' \
		google.golang.org/grpc/cmd/protoc-gen-go-grpc@${PROTOC_GEN_GO_GRPC_VERSION}

FROM gcr.io/distroless/base:nonroot AS golang
USER nonroot:nonroot
COPY --from=golang-builder --chown=nonroot:nonroot /out/ /
COPY --from=protoc --chown=nonroot:nonroot /protoc /usr/local/bin/protoc
COPY --from=protoc --chown=nonroot:nonroot /usr/local/include /usr/local/include/
LABEL maintainer="The containerz Authors" \
	org.opencontainers.image.title="gcr.io/containerz/protoc/golang" \
	org.opencontainers.image.description="protoc and protoc-gen-go related binaries container image" \
	org.opencontainers.image.url="https://github.com/containerz-dev/protoc" \
	org.opencontainers.image.source="git@github.com:containerz-dev/protoc" 
ENTRYPOINT ["protoc"]

FROM gcr.io/distroless/base:debug-nonroot AS golang-debug
USER nonroot:nonroot
COPY --from=golang-builder --chown=nonroot:nonroot /out/ /
COPY --from=protoc-debug --chown=nonroot:nonroot /protoc /usr/local/bin/protoc
COPY --from=protoc-debug --chown=nonroot:nonroot /usr/local/include /usr/local/include/
LABEL maintainer="The containerz Authors" \
	org.opencontainers.image.title="gcr.io/containerz/protoc/golang:debug" \
	org.opencontainers.image.description="protoc and protoc-gen-go related binaries container image" \
	org.opencontainers.image.url="https://github.com/containerz-dev/protoc" \
	org.opencontainers.image.source="git@github.com:containerz-dev/protoc" 
ENTRYPOINT ["protoc"]
