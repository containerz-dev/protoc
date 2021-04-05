# gcr.io/containerz/protoc

[protocolbuffers/protobuf][protocolbuffers/protobuf] container images.

### protoc versions `${PROTOC_VERSION}`

Supported:

- [v3.12.3](https://github.com/protocolbuffers/protobuf/releases/v3.12.3)
- [v3.12.4](https://github.com/protocolbuffers/protobuf/releases/v3.12.4)
- [v3.13.0](https://github.com/protocolbuffers/protobuf/releases/v3.13.0)
- [v3.14.0](https://github.com/protocolbuffers/protobuf/releases/v3.14.0)
- [v3.15.0](https://github.com/protocolbuffers/protobuf/releases/v3.15.0)
- [v3.15.1](https://github.com/protocolbuffers/protobuf/releases/v3.15.1)
- [v3.15.2](https://github.com/protocolbuffers/protobuf/releases/v3.15.2)
- [v3.15.3](https://github.com/protocolbuffers/protobuf/releases/v3.15.3)
- [v3.15.4](https://github.com/protocolbuffers/protobuf/releases/v3.15.4)
- [v3.15.5](https://github.com/protocolbuffers/protobuf/releases/v3.15.5)
- [v3.15.6](https://github.com/protocolbuffers/protobuf/releases/v3.15.6)
- [v3.15.7](https://github.com/protocolbuffers/protobuf/releases/v3.15.7)

See also [protocolbuffers/protobuf/releases][protocolbuffers/protobuf/releases].

## Container images

### [gcr.io/containerz/protoc/protoc][gcr.io/containerz/protoc/protoc]

protoc binary container images.

- gcr.io/containerz/protoc/protoc:latest
- gcr.io/containerz/protoc/protoc:${PROTOC_VERSION}
    - `FROM` [gcr.io/distroless/base:nonroot][gcr.io/distroless/base:nonroot].
- gcr.io/containerz/protoc/protoc:debug
- gcr.io/containerz/protoc/protoc:${PROTOC_VERSION}-debug
    - `FROM` [gcr.io/distroless/base:debug-nonroot][gcr.io/distroless/base:nonroot].

### [gcr.io/containerz/protoc/golang][gcr.io/containerz/protoc/golang]

protoc binary with Go protoc plugins container images.

- gcr.io/containerz/protoc/golang:latest
- gcr.io/containerz/protoc/golang:${PROTOC_VERSION}
- gcr.io/containerz/protoc/golang:${PROTOC_VERSION}-${GOLANG_VERSION}
    - `FROM` [gcr.io/distroless/base:nonroot][gcr.io/distroless/base:nonroot].
- gcr.io/containerz/protoc/golang:debug
- gcr.io/containerz/protoc/golang:${PROTOC_VERSION}-debug
- gcr.io/containerz/protoc/golang:${PROTOC_VERSION}-${GOLANG_VERSION}-debug
    - `FROM` [gcr.io/distroless/base:debug-nonroot][gcr.io/distroless/base:nonroot].

#### Go protoc plugins

- [google.golang.org/protobuf/cmd/protoc-gen-go@v1.26.0](https://github.com/protocolbuffers/protobuf-go/tree/v1.26.0)
- [google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1.0](https://github.com/grpc/grpc-go/tree/cmd/protoc-gen-go-grpc/v1.1.0/cmd/protoc-gen-go-grpc)


<!-- links -->
[gcr.io/containerz/protoc/protoc]: https://console.cloud.google.com/gcr/images/containerz/GLOBAL/protoc/protoc
[gcr.io/containerz/protoc/golang]: https://console.cloud.google.com/gcr/images/containerz/GLOBAL/protoc/golang
[protocolbuffers/protobuf]: https://github.com/protocolbuffers/protobuf
[protocolbuffers/protobuf/releases]: https://github.com/protocolbuffers/protobuf/releases
[gcr.io/distroless/base:nonroot]: https://github.com/GoogleContainerTools/distroless/tree/master/base
