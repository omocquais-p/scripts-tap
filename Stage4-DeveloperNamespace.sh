#!/bin/bash
# Add a developer namespace, registry, roles, and privileges.

WORKLOAD_NAMESPACE=${1:-"workload1"}

echo "kubectl delete ns ${WORKLOAD_NAMESPACE}"
kubectl delete ns "${WORKLOAD_NAMESPACE}"

kubectl create namespace "${WORKLOAD_NAMESPACE}"

kubectl label namespaces "${WORKLOAD_NAMESPACE}" apps.tanzu.vmware.com/tap-ns=""
kubectl get secrets,serviceaccount,rolebinding,pods,workload,configmap -n "${WORKLOAD_NAMESPACE}"

echo "DONE"