# gcr.io/containerz/protoc

[protocolbuffers/protobuf][protocolbuffers/protobuf] container images.

## Container images

### [gcr.io/containerz/protoc/protoc][gcr.io/containerz/protoc/protoc]

protoc binary container images.

- gcr.io/containerz/protoc/protoc:latest
- gcr.io/containerz/protoc/protoc:${PROTOC_VERSION}
    - `FROM` [gcr.io/distroless/static:nonroot][gcr.io/distroless/static:nonroot].
- gcr.io/containerz/protoc/protoc:debug
- gcr.io/containerz/protoc/protoc:${PROTOC_VERSION}-debug
    - `FROM` [gcr.io/distroless/base:debug-nonroot][gcr.io/distroless/static:nonroot].

### [gcr.io/containerz/protoc/golang][gcr.io/containerz/protoc/golang]

protoc binary with Go protoc plugins container images.

- gcr.io/containerz/protoc/golang:latest
- gcr.io/containerz/protoc/golang:${PROTOC_VERSION}
    - `FROM` [gcr.io/distroless/static:nonroot][gcr.io/distroless/static:nonroot].
- gcr.io/containerz/protoc/golang:debug
- gcr.io/containerz/protoc/golang:${PROTOC_VERSION}-debug
    - `FROM` [gcr.io/distroless/base:debug-nonroot][gcr.io/distroless/static:nonroot].

#### Go protoc plugins

- [github.com/envoyproxy/protoc-gen-validate@master](https://github.com/envoyproxy/protoc-gen-validate)
- [github.com/googleapis/gapic-generator-go/cmd/protoc-gen-go_cli@master](https://github.com/googleapis/gapic-generator-go/tree/master/cmd/protoc-gen-go_cli)
- [github.com/googleapis/gapic-generator-go/cmd/protoc-gen-go_gapic@master](https://github.com/googleapis/gapic-generator-go/tree/master/cmd/protoc-gen-go_gapic)
- [github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway@master](https://github.com/grpc-ecosystem/grpc-gateway/tree/master/protoc-gen-grpc-gateway)
- [github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger@master](https://github.com/grpc-ecosystem/grpc-gateway/tree/master/protoc-gen-swagger)
- [github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc@master](https://github.com/pseudomuto/protoc-gen-doc)
- [google.golang.org/grpc/cmd/protoc-gen-go-grpc@ad51f572fd27](https://github.com/grpc/grpc-go/tree/ad51f572fd27/cmd/protoc-gen-go-grpc)
- [google.golang.org/protobuf/cmd/protoc-gen-go@v1.24.0](https://github.com/protocolbuffers/protobuf-go/tree/v1.24.0)


### `${PROTOC_VERSION}`

See [protocolbuffers/protobuf/releases][protocolbuffers/protobuf/releases].


<!-- links -->
[gcr.io/containerz/protoc/protoc]: https://console.cloud.google.com/gcr/images/containerz/GLOBAL/protoc/protoc
[gcr.io/containerz/protoc/golang]: https://console.cloud.google.com/gcr/images/containerz/GLOBAL/protoc/golang
[protocolbuffers/protobuf]: https://github.com/protocolbuffers/protobuf
[protocolbuffers/protobuf/releases]: https://github.com/protocolbuffers/protobuf/releases
[gcr.io/distroless/static:nonroot]: https://github.com/GoogleContainerTools/distroless/tree/master/base

<!-- badge links -->
[cloud-build-status]: https://console.cloud.google.com/cloud-build/builds?project=containerz
