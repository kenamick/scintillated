OUTPUT_DIR 	= bin
APP_NAME 	= scintillated

BULD_FLAGS	=
LDLFAGS		= "-s -w"
CGO_ENABLED	= 1

# Detect OS and set binary name accordingly
UNAME_S := $(shell uname -s)
ifneq (Darwin linux,$(UNAME_S) $(TARGET))
    FULL_BIN_NAME = $(APP_NAME)_darwin_arm64
else
    FULL_BIN_NAME = $(APP_NAME)_linux_amd64
endif

.PHONY: all
all: clean build $(APP_NAME)

$(APP_NAME):
	-@test -d $(OUTPUT_DIR) || mkdir -p $(OUTPUT_DIR)/
ifneq (Darwin linux,$(UNAME_S) $(TARGET))
	GOOS=darwin GOARCH=arm64 CGO_ENABLED=$(CGO_ENABLED) go build $(BULD_FLAGS) -ldflags $(LDLFAGS) -o $(OUTPUT_DIR)/$(FULL_BIN_NAME) *.go
else
	GOOS=linux GOARCH=amd64 CGO_ENABLED=$(CGO_ENABLED) go build $(BULD_FLAGS) -ldflags $(LDLFAGS) -o $(OUTPUT_DIR)/$(FULL_BIN_NAME) *.go
endif

.PHONY: build
build: $(APP_NAME)

.PHONY: run
run:
	go run .

# .PHONY: live
# live:
# 	go run github.com/air-verse/air@v1.61.1 \
# 		--build.cmd "make build" \
# 		--build.bin "./$(OUTPUT_DIR)/$(FULL_BIN_NAME)" \
# 		--build.delay "250" \
# 		--build.exclude_dir "pb_data,bin" \
# 		--build.include_ext "go, tpl, tmpl, html, css, scss, js, ts, jpeg, jpg, gif, png, svg, webp, ico" \
# 		--build.rerun "true"
# 		--build.send_interrupt "true"
# 		--misc.clean_on_exit "true"

.PHONY: check
check:
	-@go vet ./...

.PHONY: clean
clean:
	-@test -d $(OUTPUT_DIR) && rm -f $(OUTPUT_DIR)/*
	-@test -d $(OUTPUT_DIR) && rmdir $(OUTPUT_DIR)