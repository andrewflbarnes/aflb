#!/usr/bin/env make -f

.SILENT:
.DEFAULT_GOAL = build

API_URL ?= "https://api.andrewflbarnes.com"
CDN_URL ?= "https://aflbcdn.com"

OUT_PATH := static
SRC_PATH := src

SRC := $(foreach x, $(SRC_PATH), $(wildcard $(addprefix $(x)/*,.*)))
OUT := $(addprefix $(OUT_PATH)/, $(notdir $(SRC)))

define get_time
$(shell date +"%T")
endef

.PHONY: clean
clean:
	@printf "$(call get_time) %-30s - Deleting folder\n" $(OUT_PATH)
	rm -rf $(OUT_PATH)

.PHONY: loop
loop:
	@echo "starting build loop"
	while make build; do sleep 1; done

.PHONY: build
build: $(OUT_PATH) $(OUT)

$(OUT_PATH):
	@printf "$(call get_time) %-30s - Creating folder\n" $@
	@mkdir $@

$(OUT_PATH)/%: $(SRC_PATH)/%
	@printf "$(call get_time) %-30s - Copy from %s\n" $@ $<
	@cp $< $@

	@if echo "$@" | grep -E "\.(js|html)$$" > /dev/null; then \
	  printf "$(call get_time) %-30s - Updating placeholders\n" $@; \
	  sed \
	    -i.delete \
	    -e 's|{{API_URL}}|'$(API_URL)'|g' \
	    -e 's|{{CDN_URL}}|'$(CDN_URL)'|g' \
	    $@; \
	    rm $@.delete; \
	fi
