help: ## Print help
	@awk 'BEGIN {FS=":.*##";printf"Makefile\n\nUsage:\n  make [command]\n\nAvailable Commands:\n"}/^[a-zA-Z_0-9-]+:.*?##/{printf"  %-40s%s\n",$$1,$$2}/^##@/{printf"\n%s\n",substr($$0,5)}' $(MAKEFILE_LIST)


gen-go: ## Generate protobuf files
	@export PATH="$PATH:/opt/homebrew/bin:/Users/ethantlee/go/bin" && \
	protoc --proto_path=proto/api-stats \
       --go_out=gen/go/api-stats --go_opt=paths=source_relative \
       --go-grpc_out=gen/go/api-stats --go-grpc_opt=paths=source_relative \
       proto/api-stats/stats.proto
