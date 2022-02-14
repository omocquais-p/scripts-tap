#!/bin/bash

set -e

TAP_NAMESPACE=${1:-"tap-install"}

echo "tanzu package installed list -A"
tanzu package installed list -A

echo

echo "kubectl get pkgi tap -n $TAP_NAMESPACE -oyaml"
kubectl get pkgi tap -n "$TAP_NAMESPACE" -oyaml

echo

echo "kubectl get pkgi contour -n $TAP_NAMESPACE -oyaml"
kubectl get pkgi contour -n "$TAP_NAMESPACE" -oyaml

echo

echo
echo "kubectl get pkgi buildservice -n $TAP_NAMESPACE -oyaml"
kubectl get pkgi buildservice -n "$TAP_NAMESPACE" -oyaml
