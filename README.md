# Useful scripts to install TAP and deploy workloads (React and Spring boot apps) in TAP

# TESTING supply chain

## TESTING supply chain - with DockerHUB - create namespace demo-react-apps and the pipeline for React application
    ./setupDeveloperNS.sh demo-react-apps ./tanzu/tekton-pipeline-react.yaml

## TESTING supply chain - with DockerHUB - create namespace demo-apps and the pipeline for Spring boot application
    ./setupDeveloperNS.sh demo-apps ./tanzu/tekton-pipeline.yaml

## TESTING supply chain - with Harbor - create workload
    ./createWorkloadWithTests.sh demo-app demo-react-apps master https://github.com/omocquais-p/react-app 
    ./createWorkloadWithTests.sh demo-hello-app demo-apps master https://github.com/omocquais-p/demo-hello-world

# BASIC supply chain

## BASIC supply chain - with Harbor - create namespace
    ./setupNS-harbor-no-pipeline.sh demo-be

## BASIC supply chain - with Harbor - create workload
    ./createWorkload.sh api demo-be master https://github.com/omocquais-p/demo-tap-be

## BASIC supply chain - with DockerHUB - create namespace
    ./setupNS-dockerhub-no-pipeline.sh demo-be

## BASIC supply chain - with DockerHUB - create workload
    ./createWorkload.sh api demo-be master https://github.com/omocquais-p/demo-tap-be


## TAP Installation

# Download Tanzu CLI, Cluster Essentials for VMware Tanzu and update the path in the script cleanInstallTanzuCLI.sh
    TANZU_HOME_DIRECTORY=$HOME/tanzu
    PATH_TANZU_CLI_TAR_FILE=$TANZU_HOME_DIRECTORY/archives/1.0.1/tanzu-framework-darwin-amd64.tar
    CLUSTER_ESSENTIALS_PATH=$TANZU_HOME_DIRECTORY/archives/tanzu-cluster-essentials-darwin-amd64-1.0.0.tgz

# Script to install Tanzu CLI, Cluster Essentials and TAP 
    ./cleanInstallTanzuCLI.sh

# Minikube folder

- minikubeStart.sh: script to start a minikube cluster
- minikubeTunnel.sh: script to start a minikube tunnel
- minikubeStop.sh: script to stop a minikube cluster

# Helpers folder
- checkTAPInstallation.sh: check TAP installation: tanzu package installed list -A
- checkPackage.sh: inspect a package: kubectl get pkgi "$PKG_NAME" -n $TAP_NAMESPACE -oyaml
    