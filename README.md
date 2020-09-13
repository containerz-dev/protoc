# gcr.io/containerz/protoc

[protocolbuffers/protobuf][protocolbuffers/protobuf] container images.

### protoc versions `${PROTOC_VERSION}`

Supported:

- [v3.13.0](https://github.com/protocolbuffers/protobuf/releases/v3.13.0)
- [v3.12.4](https://github.com/protocolbuffers/protobuf/releases/v3.12.4)
- [v3.12.3](https://github.com/protocolbuffers/protobuf/releases/v3.12.3)

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
    - `FROM` [gcr.io/distroless/base:nonroot][gcr.io/distroless/base:nonroot].
- gcr.io/containerz/protoc/golang:debug
- gcr.io/containerz/protoc/golang:${PROTOC_VERSION}-debug
    - `FROM` [gcr.io/distroless/base:debug-nonroot][gcr.io/distroless/base:nonroot].

#### Go protoc plugins

- [google.golang.org/protobuf/cmd/protoc-gen-go@v1.25.0](https://github.com/protocolbuffers/protobuf-go/tree/v1.25.0)
- [google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.32.0](https://github.com/grpc/grpc-go/tree/v1.32.0/cmd/protoc-gen-go-grpc)


<!-- links -->
[gcr.io/containerz/protoc/protoc]: https://console.cloud.google.com/gcr/images/containerz/GLOBAL/protoc/protoc
[gcr.io/containerz/protoc/golang]: https://console.cloud.google.com/gcr/images/containerz/GLOBAL/protoc/golang
[protocolbuffers/protobuf]: https://github.com/protocolbuffers/protobuf
[protocolbuffers/protobuf/releases]: https://github.com/protocolbuffers/protobuf/releases
[gcr.io/distroless/base:nonroot]: https://github.com/GoogleContainerTools/distroless/tree/master/base
