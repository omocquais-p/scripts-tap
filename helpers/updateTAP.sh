#!/bin/bash

export TAP_VERSION="1.3.0"
export TAP_NAMESPACE="tap-install"
export TAP_VALUES_FILE="tap-values.yaml"

TAP_VALUES_PATH=$HOME/tanzu/tap-values/$TAP_VERSION/$TAP_VALUES_FILE

tanzu package installed update tap -p tap.tanzu.vmware.com -v $TAP_VERSION --values-file "$TAP_VALUES_PATH" -n "$TAP_NAMESPACE"