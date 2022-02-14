#!/bin/bash

echo "loading prerequisites.sh"
source ./prerequisites.sh

echo "run cleanInstallTanzuCLI"
./cleanInstallTanzuCLI.sh

echo "loading environment.sh"
source ./environment.sh

echo
echo "kubectl config use-context tap-cluster"
kubectl config use-context tap-cluster

echo "docker logout"
docker logout 

echo "docker login"
docker login -u $DH_USERNAME -p $DH_PASSWORD

echo "./cleanInstallTanzuCLI.sh"
./cleanInstallTanzuCLI.sh


kubectl create ns tap-install

tanzu secret registry add tap-registry \
  --username ${INSTALL_REGISTRY_USERNAME} --password ${INSTALL_REGISTRY_PASSWORD} \
  --server ${INSTALL_REGISTRY_HOSTNAME} \
  --export-to-all-namespaces --yes --namespace tap-install

tanzu package repository add tanzu-tap-repository \
  --url registry.tanzu.vmware.com/tanzu-application-platform/tap-packages:1.0.1 \
  --namespace tap-install

echo "tanzu package install tap -p tap.tanzu.vmware.com -v 1.0.1 --values-file $HOME/tanzu/tap-values-docker-testing.yaml -n tap-install"
tanzu package install tap -p tap.tanzu.vmware.com -v 1.0.1 --values-file $HOME/tanzu/tap-values-docker-testing.yaml -n tap-install

