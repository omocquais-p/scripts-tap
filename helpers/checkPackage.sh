#!/bin/bash

set -e

PKG_NAME=${1:-"tap"}
TAP_NAMESPACE="tap-install"

echo
echo "kubectl get pkgi $PKG_NAME -n $TAP_NAMESPACE -oyaml"
kubectl get pkgi "$PKG_NAME" -n $TAP_NAMESPACE -oyaml
