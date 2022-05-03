#!/bin/bash

set -e

WORKLOAD_NAME=${1:-"sample-app"}
WORKLOAD_NAMESPACE=${2:-"tanzu-labs"}
GIT_BRANCH_NAME=${3:-"main"}
GIT_REPO=${4:-"https://github.com/sample-accelerators/tanzu-java-web-app"}

echo "create workload for BASIC supply chain"
echo "WORKLOAD_NAME: $WORKLOAD_NAME WORKLOAD_NAMESPACE: $WORKLOAD_NAMESPACE GIT_BRANCH_NAME: $GIT_BRANCH_NAME GIT_REPO: $GIT_REPO"
tanzu apps workload create "$WORKLOAD_NAME" \
  --git-repo "$GIT_REPO" \
  --git-branch "$GIT_BRANCH_NAME" \
  --type web \
  --label app.kubernetes.io/part-of="$WORKLOAD_NAME" \
  --label tanzu.app.live.view=true \
  --label tanzu.app.live.view.application.name="$WORKLOAD_NAME" \
  --namespace "$WORKLOAD_NAMESPACE" \
  --tail-timestamp \
  --yes