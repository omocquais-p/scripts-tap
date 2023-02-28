# TAP 1.4

This document describes how to install TAP 1.4 and how to deploy a simple back-end application (Java / Spring boot application) and a simple web application (React) with the Basic supply chain from Tanzu Application Platform (TAP 1.4).

## Clone the GitHub repository:
    https://github.com/omocquais-p/scripts-tap

## Update the credentials in the env.yaml file
    installRegistry: Tanzu Network account
    registry: Google Artifact Registry credentials

## Install yq
    https://github.com/mikefarah/yq

## Create a tanzu folder
    TANZU_HOME_DIRECTORY=$HOME/tanzu

## Download the Tanzu CLI file into the folder 
    $TANZU_HOME_DIRECTORY/archives/1.4.0/tanzu-framework-darwin-amd64-v0.25.4.2.tar

## Download the tanzu-cluster-essentials file into the folder
    $TANZU_HOME_DIRECTORY/archives/essentials/1.4.0/tanzu-cluster-essentials-darwin-amd64-1.4.0.tgz

## Create a tap-values.yaml from the tap-values/tap-values.yaml
    $TANZU_HOME_DIRECTORY/tap-values/1.4.0/tap-values.yaml

## Tanzu CLI Installation
    ./Stage1-cleanInstallTanzuCLI.sh

## Install Cluster Essentials
    ./Stage2-installClusterEssentials.sh

## Install TAP 
    ./Stage3-installTAP.sh

## You can check the installation by running this command:
    ./helpers/checkTAPInstallation.sh

## Create the Developer Namespace (Back-End) 
    ./Stage4-DeveloperNamespace.sh demo-tap-be

## Deploy the workload (Back-End)
    ./Stage5-Deploy-Workload.sh api demo-tap-be master https://github.com/omocquais-p/demo-tap-be

### Get external IP address (envoy) 
    kubectl get service envoy -n tanzu-system-ingress
    NAME    TYPE           CLUSTER-IP     EXTERNAL-IP    PORT(S)                      AGE
    envoy   LoadBalancer   10.48.14.176   xx.xx.xx.xx   80:32385/TCP,443:32226/TCP   2d21h

### Update /etc/hosts with the external IP address (envoy)
    xx.xx.xx.xx tap-gui.gke.tap.io api.demo-tap-be.gke.tap.io

## Create the Developer Namespace (Front-End)
    ./Stage4-DeveloperNamespace.sh demo-tap-fe

## Get the API endpoint and update the Stage6-Deploy-Workload-frontend.sh script

## Deploy the workload (Front-End)
    ./Stage6-Deploy-Workload-frontend.sh web demo-tap-fe master https://github.com/omocquais-p/demo-tap-fe

### Update /etc/hosts
    xx.xx.xx.xx tap-gui.gke.tap.io api.demo-tap-be.gke.tap.io web.demo-tap-fe.gke.tap.io