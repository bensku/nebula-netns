#!/bin/bash
set -euo pipefail

export GOOS=linux # We're using Linux network namespaces, which are by definition platform-specific
GOARCH=amd64 go build -o nebula-netns-linux-amd64
GOARCH=arm64 go build -o nebula-netns-linux-arm64