# TAP 1.1

## Clone the GitHub repository:
    https://github.com/omocquais-p/scripts-tap

## Update the credentials in the environment.sh file and source the file
    source environment.sh

## Tanzu CLI Installation
    ./Stage1-cleanInstallTanzuCLI.sh

## Install Cluster Essentials
    ./Stage3-installClusterEssentials.sh

## Create the namespace (used by grype defined in the tap-values.yaml file)
    kubectl create ns demo-app
    ./Stage4-installTAP.sh

## You can check the installation by running this command:
    helpers/checkTAPInstallation.sh

## Create the Developer Namespace 
    ./Stage5-DeveloperNamespace.sh demo-tap-be

## Create the pipeline
    ./Stage6-Deploy-pipeline.sh demo-tap-be

## Deploy the workload
    ./Stage7-Deploy-Workload.sh api demo-tap-be master https://github.com/omocquais-p/demo-tap-be