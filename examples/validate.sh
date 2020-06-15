#!/usr/bin/env sh

set -eu

for example in ./examples/*; do
  sh -c "cd $example && terraform init && terraform validate"
done
