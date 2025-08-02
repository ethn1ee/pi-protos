export PATH := $(shell go env GOPATH)/bin:$(PWD)/node_modules/.bin:$(PATH)

.PHONY: gen
gen: gen-go gen-ts

.PHONY: gen-go
gen-go:
	@go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	@go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	@mkdir -p gen/go
	@protoc --go_out=./gen/go --go_opt=paths=source_relative \
		--go-grpc_out=./gen/go --go-grpc_opt=paths=source_relative \
		api-stats/*.proto

.PHONY: gen-ts
gen-ts:
	@pnpm install
	@./node_modules/.bin/buf generate --output gen/ts

