#!/usr/bin/env sh

set -eu

find examples/ -type d -mindepth 1 -maxdepth 1 -exec sh -c 'cd $1 && terraform init && terraform validate' _ {} \;