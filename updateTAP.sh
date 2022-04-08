#!/bin/bash

export TAP_VERSION="1.0.3"
export TAP_NAMESPACE="tap-install"

TAP_VALUES_PATH=$HOME/tanzu/tap-values-docker.yaml

tanzu package installed update tap -p tap.tanzu.vmware.com -v $TAP_VERSION --values-file "$TAP_VALUES_PATH" -n "$TAP_NAMESPACE"