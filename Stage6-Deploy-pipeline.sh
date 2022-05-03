#!/bin/bash

WORKLOAD_NAMESPACE=${1:-"my-apps"}
PIPELINE=${2:-"./tanzu/tekton-pipeline.yaml"}

#Tekton pipeline
echo "kubectl -n $WORKLOAD_NAMESPACE apply -f $PIPELINE"
kubectl -n $WORKLOAD_NAMESPACE apply -f $PIPELINE