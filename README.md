# Useful scripts to install TAP and deploy workloads (React and Spring boot apps) in TAP

# TESTING supply chain

## Front-end (simple react application)

### Create the developer namespace with the associated pipeline

#### DockerHUB
    ./setupDeveloperNS.sh demo-react-apps ./tanzu/tekton-pipeline-react.yaml

#### Harbor
    ./setupNS-harbor-with-pipeline.sh demo-react-apps ./tanzu/harbor/tekton-pipeline-js.yaml

### Create a workload (react) in TAP
    ./createWorkloadWithTests.sh demo-app demo-react-apps master https://github.com/omocquais-p/react-app
    
## Back-end (simple spring boot application)

### Create the developer namespace with the associated pipeline

#### DockerHUB 
    ./setupDeveloperNS.sh demo-apps ./tanzu/tekton-pipeline.yaml

#### Harbor
    ./setupNS-harbor-with-pipeline.sh demo-apps ./tanzu/harbor/tekton-pipeline.yaml

### Create a workload (spring boot app) in TAP 
    ./createWorkloadWithTests.sh demo-hello-app demo-apps master https://github.com/omocquais-p/demo-hello-world


# BASIC supply chain

## Front-end (simple react application)

### Create the developer namespace

#### DockerHUB
    ./setupNS-dockerhub-no-pipeline.sh demo-react-apps

#### Harbor
    ./setupNS-harbor-no-pipeline.sh demo-react-apps

### Create a workload (react) in TAP
    ./createWorkload.sh demo-app  demo-react-apps master https://github.com/omocquais-p/react-app

## Back-end (simple spring boot application)

### Create the developer namespace
    ./setupNS-dockerhub-no-pipeline.sh demo-be

### Create a workload (spring boot app) in TAP
    ./createWorkload.sh api demo-be master https://github.com/omocquais-p/demo-tap-be


## TAP Installation

# Download Tanzu CLI, Cluster Essentials for VMware Tanzu and update the path in the cleanInstallTanzuCLI.sh script 
    TANZU_HOME_DIRECTORY=$HOME/tanzu
    PATH_TANZU_CLI_TAR_FILE=$TANZU_HOME_DIRECTORY/archives/1.0.1/tanzu-framework-darwin-amd64.tar
    CLUSTER_ESSENTIALS_PATH=$TANZU_HOME_DIRECTORY/archives/tanzu-cluster-essentials-darwin-amd64-1.0.0.tgz

# Run the script to install Tanzu CLI, Cluster Essentials and TAP 
    ./cleanInstallTanzuCLI.sh

# Minikube folder

## minikubeStart.sh 
- script to start a minikube cluster
## minikubeTunnel.sh
- script to start a minikube tunnel
## minikubeStop.sh
- script to stop a minikube cluster

# Helpers folder

## checkTAPInstallation.sh: check TAP installation
    tanzu package installed list -A
## checkPackage.sh: inspect a package
    kubectl get pkgi "$PKG_NAME" -n $TAP_NAMESPACE -oyaml 