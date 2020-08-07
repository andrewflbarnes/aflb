#!/usr/bin/env make -f
.SILENT:
.DEFAULT_GOAL = build

API_URL ?= "https://api.andrewflbarnes.com"
CDN_URL ?= "https://aflbcdn.com"
# modifies "/" characters to prevent sed misinterpretation
SED_API_URL = $(shell sed 's/\//\\\\\//g' <<< $(API_URL))
SED_CDN_URL = $(shell sed 's/\//\\\\\//g' <<< $(CDN_URL))


OUT_PATH := static
SRC_PATH := src

SRC := $(foreach x, $(SRC_PATH), $(wildcard $(addprefix $(x)/*,.*)))
OUT := $(addprefix $(OUT_PATH)/, $(notdir $(SRC)))

.PHONY: clean
clean:
	@printf "%-30s - Deleting folder\n" $(OUT_PATH)
	rm -rf $(OUT_PATH)

.PHONY: loop
loop:
	@echo "starting build loop"
	while make build; do sleep 1; done &

.PHONY: build
build: $(OUT_PATH) $(OUT)

$(OUT_PATH):
	@printf "%-30s - Creating folder\n" $@
	@mkdir $@

$(OUT_PATH)/%: $(SRC_PATH)/%
	@printf "%-30s - Copy from %s\n" $@ $<
	@cp $< $@
	@if [[ "$@" =~ .(js|html)$$ ]]; then \
	  printf "%-30s - Updating placeholders\n" $@; \
	  sed -i.delete ' \
	    s/{{API_URL}}/'$(SED_API_URL)'/g; \
	    s/{{CDN_URL}}/'$(SED_CDN_URL)'/g; \
	  ' $@; \
	  rm $@.delete; \
	fi
