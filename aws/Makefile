#!/usr/bin/enf make -f

.DEFAULT_GOAL = build
.SILENT:

target = aflb_contact_lambda.zip

help:
	echo "help:   this help text"
	echo "build:  (default) create the lambda zip file"
	echo "deploy: deploy the aws lambda function using terraform apply"

.PHONY: build
build: $(target)

$(target): index.js
	echo removing $(target)
	rm -f $(target)

	echo building $(target)
	zip $@ $^

.PHONY: deploy
deploy: build
	terraform apply