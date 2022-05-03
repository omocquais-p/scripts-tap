#!/bin/bash

CLUSTER_NAME=${1:-"tap-cluster"}

echo "minikube stop -p tap-cluster"
minikube stop -p "$CLUSTER_NAME"
