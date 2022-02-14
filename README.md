# Create the namespace demo-react-apps and the pipeline for React application
    ./setupDeveloperNS.sh demo-react-apps ./tanzu/tekton-pipeline-react.yaml

# Create the namespace demo-apps and the pipeline for Spring boot application    
    ./setupDeveloperNS.sh demo-apps ./tanzu/tekton-pipeline.yaml

# Deploy a workload
    ./createWorkloadWithTests.sh demo-app demo-react-apps https://github.com/omocquais-p/react-app master
    ./createWorkloadWithTests.sh demo-hello-app demo-apps https://github.com/omocquais-p/demo-hello-world master

# Cluster essentials - download the required artifacts and update if needed the filenames
    TANZU_HOME_DIRECTORY=$HOME/tanzu
    PATH_TANZU_CLI_TAR_FILE=$TANZU_HOME_DIRECTORY/archives/1.0.1/tanzu-framework-darwin-amd64.tar
    CLUSTER_ESSENTIALS_PATH=$TANZU_HOME_DIRECTORY/archives/tanzu-cluster-essentials-darwin-amd64-1.0.0.tgz