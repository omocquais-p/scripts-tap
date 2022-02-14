#!/bin/bash

set -e

CLUSTER_NAME=${1:-"tap-cluster"}

minikube start -p $CLUSTER_NAME
