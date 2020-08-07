#!/usr/bin/enf make -f

.DEFAULT_GOAL = build
.SILENT:

lambda_source = contact_lambda.zip

swagger_file = swagger.yml
swagger_owner = andrewflbarnes
swagger_name = andrewflbarnes
swagger_version = 1.0.0
swagger_spec = $(swagger_owner)/$(swagger_name)/$(swagger_version)
swagger_url = https://api.swaggerhub.com/apis/$(swagger_spec)/swagger.yaml

help:
	echo "help:   this help text"
	echo "build:  (default) create the lambda zip file and download swagger spec"
	echo "deploy: deploy the aws lambda function using terraform apply"
	echo "clean:  delete all targets"

.PHONY: clean
clean:
	rm -f $(lambda_source)
	rm -f $(swagger_file)

.PHONY: build
build: $(lambda_source) $(swagger_file)

$(swagger_file):
	echo Downloading swagger spec $(swagger_spec) to $(swagger_file)
	curl https://api.swaggerhub.com/apis/$(swagger_spec)/swagger.yaml > $@ 2>/dev/null

$(lambda_source): index.js
	echo Building $@
	zip $@ $^

.PHONY: deploy
deploy: build
	terraform apply