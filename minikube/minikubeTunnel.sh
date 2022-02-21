#!/bin/bash

set -e

CLUSTER_NAME=${1:-"tap-cluster"}

echo "minikube tunnel -p $CLUSTER_NAME --cleanup"
minikube tunnel -p "$CLUSTER_NAME" --cleanup
