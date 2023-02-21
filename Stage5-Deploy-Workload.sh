#!/bin/bash

set -e

WORKLOAD_NAME=${1:-"demo-tap-be"}
WORKLOAD_NAMESPACE=${2:-"workload1"}
GIT_BRANCH_NAME=${3:-"master"}
GIT_REPO=${4:-"https://github.com/omocquais-p/demo-tap-be.git"}

echo "create workload for BASIC supply chain"
echo "WORKLOAD_NAME: $WORKLOAD_NAME WORKLOAD_NAMESPACE: $WORKLOAD_NAMESPACE GIT_BRANCH_NAME: $GIT_BRANCH_NAME GIT_REPO: $GIT_REPO"

#echo "tanzu apps workload create ${WORKLOAD_NAME} --git-repo ${GIT_REPO} --git-branch ${GIT_BRANCH_NAME} --type web --label apps.tanzu.vmware.com/has-tests=true  --label app.kubernetes.io/part-of=${WORKLOAD_NAME} --yes  --namespace ${WORKLOAD_NAMESPACE}"

tanzu apps workload create "${WORKLOAD_NAME}" \
    --git-repo "${GIT_REPO}" \
    --git-branch "${GIT_BRANCH_NAME}" \
    --type web \
    --label apps.tanzu.vmware.com/has-tests=true \
    --label app.kubernetes.io/part-of="${WORKLOAD_NAME}" \
    --yes \
    --namespace "${WORKLOAD_NAMESPACE}"

#tanzu apps workload create "${WORKLOAD_NAME}" \
#    --git-repo "${GIT_REPO}" \
#    --git-branch "${GIT_BRANCH_NAME}" \
#    --type web \
#    --label apps.tanzu.vmware.com/has-tests=true \
#    --label app.kubernetes.io/part-of="${WORKLOAD_NAME}" \
#    --yes \
#    --env "REACT_APP_API_URL=https://xxxxxxxxxxx/films/" \
#    --namespace "${WORKLOAD_NAMESPACE}"

tanzu apps workload tail "${WORKLOAD_NAME}" --namespace "${WORKLOAD_NAMESPACE}" --timestamp --since 1h