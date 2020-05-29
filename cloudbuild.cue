steps: [{
	id:   "protoc"
	name: "docker.io/library/docker:19.03"
	args: [
		"image",
		"build",
		"--pull",
		"--build-arg",
		"PROTOC_VERSION=${_PROTOC_VERSION}",
		"--build-arg",
		"GOLANG_VERSION=${_GOLANG_VERSION}",
		"--build-arg",
		"ALPINE_VERSION=${_ALPINE_VERSION}",
		"--build-arg",
		"GO_PROTOC_GEN_PACKAGES=${_GO_PROTOC_GEN_PACKAGES}",
		"--target=protoc",
		"--tag",
		"gcr.io/$PROJECT_ID/protoc/protoc:${_PROTOC_VERSION}",
		"--tag",
		"gcr.io/$PROJECT_ID/protoc/protoc:latest",
		".",
	]
}, {
	id:   "protoc-debug"
	name: "docker.io/library/docker:19.03"
	args: [
		"image",
		"build",
		"--pull",
		"--build-arg",
		"PROTOC_VERSION=${_PROTOC_VERSION}",
		"--build-arg",
		"GOLANG_VERSION=${_GOLANG_VERSION}",
		"--build-arg",
		"ALPINE_VERSION=${_ALPINE_VERSION}",
		"--build-arg",
		"GO_PROTOC_GEN_PACKAGES=${_GO_PROTOC_GEN_PACKAGES}",
		"--target=protoc-debug",
		"--tag",
		"gcr.io/$PROJECT_ID/protoc/protoc:${_PROTOC_VERSION}-debug",
		"--tag",
		"gcr.io/$PROJECT_ID/protoc/protoc:debug",
		".",
	]
}, {
	id:   "go"
	name: "docker.io/library/docker:19.03"
	args: [
		"image",
		"build",
		"--pull",
		"--build-arg",
		"PROTOC_VERSION=${_PROTOC_VERSION}",
		"--build-arg",
		"GOLANG_VERSION=${_GOLANG_VERSION}",
		"--build-arg",
		"ALPINE_VERSION=${_ALPINE_VERSION}",
		"--build-arg",
		"GO_PROTOC_GEN_PACKAGES=${_GO_PROTOC_GEN_PACKAGES}",
		"--target=go",
		"--tag",
		"gcr.io/$PROJECT_ID/protoc/go:${_PROTOC_VERSION}",
		"--tag",
		"gcr.io/$PROJECT_ID/protoc/go:latest",
		".",
	]
}, {
	id:   "go-debug"
	name: "docker.io/library/docker:19.03"
	args: [
		"image",
		"build",
		"--pull",
		"--build-arg",
		"PROTOC_VERSION=${_PROTOC_VERSION}",
		"--build-arg",
		"GOLANG_VERSION=${_GOLANG_VERSION}",
		"--build-arg",
		"ALPINE_VERSION=${_ALPINE_VERSION}",
		"--build-arg",
		"GO_PROTOC_GEN_PACKAGES=${_GO_PROTOC_GEN_PACKAGES}",
		"--target=go-debug",
		"--tag",
		"gcr.io/$PROJECT_ID/protoc/go:${_PROTOC_VERSION}-debug",
		"--tag",
		"gcr.io/$PROJECT_ID/protoc/go:debug",
		".",
	]
}]

substitutions: {
	_PROTOC_VERSION:         "3.12.2"
	_GRPC_VERSION:           "1.29.1"
	_GOLANG_VERSION:         "1.14"
	_ALPINE_VERSION:         "3.11"
	_GO_PROTOC_GEN_PACKAGES: "github.com/envoyproxy/protoc-gen-validate@master github.com/googleapis/gapic-generator-go/cmd/protoc-gen-go_cli@master github.com/googleapis/gapic-generator-go/cmd/protoc-gen-go_gapic@master github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway@master github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger@master github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc@master google.golang.org/grpc/cmd/protoc-gen-go-grpc@6c9e30c09db2 google.golang.org/protobuf/cmd/protoc-gen-go@v1.24.0"
}

images: [
	"gcr.io/$PROJECT_ID/protoc/protoc:${_PROTOC_VERSION}",
	"gcr.io/$PROJECT_ID/protoc/protoc:latest",
	"gcr.io/$PROJECT_ID/protoc/protoc:${_PROTOC_VERSION}-debug",
	"gcr.io/$PROJECT_ID/protoc/protoc:debug",
	"gcr.io/$PROJECT_ID/protoc/go:${_PROTOC_VERSION}",
	"gcr.io/$PROJECT_ID/protoc/go:latest",
	"gcr.io/$PROJECT_ID/protoc/go:${_PROTOC_VERSION}-debug",
	"gcr.io/$PROJECT_ID/protoc/go:debug",
]

tags: ["protoc.protoc", "protoc.golang"]

options: machineType: "N1_HIGHCPU_8"

timeout: "1800s"
