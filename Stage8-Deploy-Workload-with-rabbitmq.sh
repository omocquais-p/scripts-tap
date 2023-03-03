#!/bin/bash

WORKLOAD_NAMESPACE=${1:-"demo-tap-be"}
GIT_REPO=${2:-"https://github.com/omocquais-p/simple-scs-functions"}
APP_NAME=${3:-"simple-scs-functions"}
SERVICE_CLAIM_NAME=rmq-1

echo "tanzu service class-claim create ${SERVICE_CLAIM_NAME} --class rabbitmq --namespace ${WORKLOAD_NAMESPACE}"
tanzu service class-claim create "${SERVICE_CLAIM_NAME}" --class rabbitmq -n "${WORKLOAD_NAMESPACE}"

echo "tanzu services class-claims list --namespace ${WORKLOAD_NAMESPACE}"
tanzu services class-claims list --namespace "${WORKLOAD_NAMESPACE}"

echo "tanzu services class-claims get ${SERVICE_CLAIM_NAME} --namespace ${WORKLOAD_NAMESPACE}"
tanzu services class-claims get "${SERVICE_CLAIM_NAME}" --namespace "${WORKLOAD_NAMESPACE}"

tanzu apps workload create "${APP_NAME}" \
--git-repo "${GIT_REPO}" \
--git-branch master \
--type web \
--label app.kubernetes.io/part-of="${APP_NAME}" \
--annotation autoscaling.knative.dev/minScale=1 \
--namespace "${WORKLOAD_NAMESPACE}" \
--build-env BP_JVM_VERSION=17 \
--service-ref="rmq=services.apps.tanzu.vmware.com/v1alpha1:ClassClaim:${SERVICE_CLAIM_NAME}"