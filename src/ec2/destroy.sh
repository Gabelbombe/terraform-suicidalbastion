#!/usr/bin/env bash

set +e

## Shutdown and terminate instance in ${10} hours
echo "sudo halt" |at now + ${1} hours
