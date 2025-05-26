#!/bin/bash
set -euo pipefail

version="1.9.5-netns0"

export GOOS=linux # We're using Linux network namespaces, which are by definition platform-specific
GOARCH=amd64 go build -o nebula-netns-linux-amd64 -ldflags "-X main.Build=$version"
GOARCH=arm64 go build -o nebula-netns-linux-arm64 -ldflags "-X main.Build=$version"