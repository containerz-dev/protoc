steps: [{
	id:   "protoc"
	name: "gcr.io/kaniko-project/executor:latest"
	args: [
		"--cache=true",
		"--dockerfile=Dockerfile",
		"--context=dir:///workspace",
		"--destination=gcr.io/$PROJECT_ID/protoc/protoc:${_PROTOC_VERSION}",
		"--destination=gcr.io/$PROJECT_ID/protoc/protoc:latest",
		"--reproducible",
		"--skip-unused-stages=true",
		"--target=protoc",
		"--build-arg=PROTOC_VERSION=${_PROTOC_VERSION}",
		"--build-arg=GOLANG_VERSION=${_GOLANG_VERSION}",
		"--build-arg=ALPINE_VERSION=${_ALPINE_VERSION}",
	]
}, {
	id:   "protoc-debug"
	name: "gcr.io/kaniko-project/executor:latest"
	args: [
		"--cache=true",
		"--dockerfile=Dockerfile",
		"--context=dir:///workspace",
		"--destination=gcr.io/$PROJECT_ID/protoc/protoc:${_PROTOC_VERSION}-debug",
		"--destination=gcr.io/$PROJECT_ID/protoc/protoc:debug",
		"--reproducible",
		"--skip-unused-stages=true",
		"--target=protoc-debug",
		"--build-arg=PROTOC_VERSION=${_PROTOC_VERSION}",
		"--build-arg=GOLANG_VERSION=${_GOLANG_VERSION}",
		"--build-arg=ALPINE_VERSION=${_ALPINE_VERSION}",
	]
}, {
	id:   "golang"
	name: "gcr.io/kaniko-project/executor:latest"
	args: [
		"--cache=true",
		"--dockerfile=Dockerfile",
		"--context=dir:///workspace",
		"--destination=gcr.io/$PROJECT_ID/protoc/golang:${_PROTOC_VERSION}",
		"--destination=gcr.io/$PROJECT_ID/protoc/golang:latest",
		"--reproducible",
		"--skip-unused-stages=true",
		"--target=golang",
		"--build-arg=PROTOC_VERSION=${_PROTOC_VERSION}",
		"--build-arg=GOLANG_VERSION=${_GOLANG_VERSION}",
		"--build-arg=PROTOC_GEN_GO_VERSION=${_PROTOC_GEN_GO_VERSION}",
		"--build-arg=PROTOC_GEN_GO_GRPC_VERSION=${_PROTOC_GEN_GO_GRPC_VERSION}",
	]
}, {
	id:   "golang-debug"
	name: "gcr.io/kaniko-project/executor:latest"
	args: [
		"--cache=true",
		"--dockerfile=Dockerfile",
		"--context=dir:///workspace",
		"--destination=gcr.io/$PROJECT_ID/protoc/golang:${_PROTOC_VERSION}-debug",
		"--destination=gcr.io/$PROJECT_ID/protoc/golang:debug",
		"--reproducible",
		"--skip-unused-stages=true",
		"--target=golang-debug",
		"--build-arg=PROTOC_VERSION=${_PROTOC_VERSION}",
		"--build-arg=GOLANG_VERSION=${_GOLANG_VERSION}",
		"--build-arg=ALPINE_VERSION=${_ALPINE_VERSION}",
		"--build-arg=PROTOC_GEN_GO_VERSION=${_PROTOC_GEN_GO_VERSION}",
		"--build-arg=PROTOC_GEN_GO_GRPC_VERSION=${_PROTOC_GEN_GO_GRPC_VERSION}",
	]
}]

substitutions: {
	_PROTOC_VERSION:             "3.12.2"
	_GOLANG_VERSION:             "1.14"
	_ALPINE_VERSION:             "3.11"
	_PROTOC_GEN_GO_VERSION:      "v1.24.0"
	_PROTOC_GEN_GO_GRPC_VERSION: "ad51f572fd27"
}

tags: [
	"protoc-protoc",
	"protoc-golang",
]

options: machineType: "N1_HIGHCPU_8"

timeout: "1800s"
