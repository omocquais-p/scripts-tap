#!/bin/bash
# Add a developer namespace, registry, roles, and privileges.

WORKLOAD_NAMESPACE=${1:-"my-apps"}

echo "kubectl delete ns $WORKLOAD_NAMESPACE"
kubectl delete ns $WORKLOAD_NAMESPACE

echo "kubectl create ns $WORKLOAD_NAMESPACE"
kubectl create ns $WORKLOAD_NAMESPACE

#Add Secret
tanzu secret registry add registry-credentials --server https://index.docker.io/v1/ --username $DH_USERNAME --password $DH_PASSWORD --namespace $WORKLOAD_NAMESPACE

echo "namespace $WORKLOAD_NAMESPACE"
echo "Add placeholder read secrets, a service account, and RBAC rules to the developer namespace by running:"
cat <<EOF | kubectl -n $WORKLOAD_NAMESPACE apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: tap-registry
  annotations:
    secretgen.carvel.dev/image-pull-secret: ""
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: e30K
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: default
secrets:
  - name: registry-credentials
imagePullSecrets:
  - name: registry-credentials
  - name: tap-registry
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: default-permit-deliverable
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: deliverable
subjects:
  - kind: ServiceAccount
    name: default
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: default-permit-workload
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: workload
subjects:
  - kind: ServiceAccount
    name: default
EOF

echo "DONE"