THIS_FILE := $(lastword $(MAKEFILE_LIST))

APP_NAME := go-webapp-template
APP_PATH := github.com/USA-RedDragon/go-webapp-template

EXTERNAL_TOOLS=\
	github.com/elazarl/go-bindata-assetfs/... \
	github.com/jteeuwen/go-bindata/... \
	github.com/gorilla/mux \
	github.com/mitchellh/gox

GOFMT_FILES?=$$(find . -name '*.go' | grep -v vendor)

install-dependencies:
	@for tool in $(EXTERNAL_TOOLS) ; do \
		echo "Installing/Updating $$tool" ; \
		go get -u $$tool; \
	done

fmt:
	gofmt -w $(GOFMT_FILES)

build-frontend:
	@echo "--> Installing JavaScript assets"
	@cd frontend && npm ci
	@echo "--> Building Vue application"
	@cd frontend && npm run build
	@$(MAKE) -f $(THIS_FILE) fmt

pack-frontend:
	@go-bindata-assetfs -o http/bindata_assetfs.go -pkg http -modtime 1480000000 -prefix frontend/ frontend/dist/...

build: install-dependencies build-frontend pack-frontend
	@echo "--> Building"
	@APP_NAME="$(APP_NAME)" APP_PATH="$(APP_PATH)" sh -c "'$(CURDIR)/scripts/build.sh'"
	@echo "--> Done"

run:
	@echo "--> Running"
	@go run main.go
	@echo "--> Done"