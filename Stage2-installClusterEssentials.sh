#!/bin/bash

# Install Cluster Essentials for VMware Tanzu onto k8s cluster

set -e

export INSTALL_REGISTRY_USERNAME=$(yq '.settings.installRegistry.username' env.yaml)
export INSTALL_REGISTRY_PASSWORD=$(yq '.settings.installRegistry.password' env.yaml)
export INSTALL_REGISTRY_HOSTNAME=$(yq '.settings.installRegistry.hostname' env.yaml)

if [[ -z "$INSTALL_REGISTRY_USERNAME" ]]; then
    echo "Must provide INSTALL_REGISTRY_USERNAME in environment" 1>&2
    exit 1
fi

if [[ -z "$INSTALL_REGISTRY_PASSWORD" ]]; then
    echo "Must provide INSTALL_REGISTRY_PASSWORD in environment" 1>&2
    exit 1
fi

if [[ -z "$INSTALL_REGISTRY_HOSTNAME" ]]; then
    echo "Must provide INSTALL_REGISTRY_HOSTNAME in environment" 1>&2
    exit 1
fi

# Remove previous directory
rm -rf "$HOME"/tanzu-cluster-essentials

# Create a directory for these packages
mkdir -p "$HOME"/tanzu-cluster-essentials

# TAP 1.4
BUNDLE_SHA=2354688e46d4bb4060f74fca069513c9b42ffa17a0a6d5b0dbb81ed52242ea44

# Define environment variables nesessary for the install scripts
export INSTALL_BUNDLE=registry.tanzu.vmware.com/tanzu-cluster-essentials/cluster-essentials-bundle@sha256:$BUNDLE_SHA

# Tanzu directory
TANZU_HOME_DIRECTORY=$HOME/tanzu

# Cluster essentials
CLUSTER_ESSENTIALS_VERSION=1.4.0
CLUSTER_ESSENTIALS_PATH=$TANZU_HOME_DIRECTORY/archives/essentials/$CLUSTER_ESSENTIALS_VERSION/tanzu-cluster-essentials-darwin-amd64-$CLUSTER_ESSENTIALS_VERSION.tgz

if [ -f "$CLUSTER_ESSENTIALS_PATH" ]; then
    echo "$CLUSTER_ESSENTIALS_PATH exists."
else
    echo "$CLUSTER_ESSENTIALS_PATH does not exist and must be present."
fi

# Unpack the TAR file into the tanzu-cluster-essentials directory by running:
tar -xvf "$CLUSTER_ESSENTIALS_PATH" -C "$HOME"/tanzu-cluster-essentials

# Change the directory
cd "$HOME"/tanzu-cluster-essentials

./install.sh --yes

sudo cp "$HOME"/tanzu-cluster-essentials/kapp /usr/local/bin/kapp