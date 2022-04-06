#!/bin/bash

set -e

WORKLOAD_NAME=${1:-"sample-app"}
WORKLOAD_NAMESPACE=${2:-"tanzu-labs"}
GIT_BRANCH_NAME=${3:-"main"}
GIT_REPO=${4:-"https://github.com/sample-accelerators/tanzu-java-web-app"}

echo "create workload for TESTING Supply Chain"
echo "$WORKLOAD_NAME $WORKLOAD_NAMESPACE $GIT_BRANCH_NAME $GIT_REPO "

tanzu apps workload create "$WORKLOAD_NAME" \
  --git-repo $GIT_REPO \
  --git-branch $GIT_BRANCH_NAME \
  --type web \
  --label app.kubernetes.io/part-of="$WORKLOAD_NAME" \
  --label apps.tanzu.vmware.com/has-tests=true \
  --namespace "$WORKLOAD_NAMESPACE" \
  --tail-timestamp \
  --yes
