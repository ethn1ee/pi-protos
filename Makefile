help: ## Print help message
	@awk 'BEGIN {FS=":.*##";printf"Usage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"}/^[a-zA-Z_0-9-]+:.*?##/{printf"  \033[36m%-15s\033[0m%s\n",$$1,$$2}' $(MAKEFILE_LIST)

.PHONY: gen-go
gen-go: ## Generate Go protobuf and gRPC files
	@echo "--- Generating Go files ---"
	@export PATH=$(shell go env GOPATH)/bin:$(PATH); \
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest; \
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest; \
	mkdir -p gen/go; \
	find proto -name "*.proto" -print0 | xargs -0 -I {} protoc \
		--proto_path=proto \
		--go_out=gen/go --go_opt=paths=source_relative \
		--go-grpc_out=gen/go --go-grpc_opt=paths=source_relative {};

.PHONY: clean
clean:
	@rm -rf gen
