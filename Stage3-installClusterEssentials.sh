#!/bin/bash

# Install Cluster Essentials for VMware Tanzu onto k8s cluster

set -e

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

BUNDLE_SHA=e00f33b92d418f49b1af79f42cb13d6765f1c8c731f4528dfff8343af042dc3e

# Define environment variables nesessary for the install scripts
export INSTALL_BUNDLE=registry.tanzu.vmware.com/tanzu-cluster-essentials/cluster-essentials-bundle@sha256:$BUNDLE_SHA

# Tanzu directory
TANZU_HOME_DIRECTORY=$HOME/tanzu

# Cluster essentials
CLUSTER_ESSENTIALS_VERSION=1.2.0
CLUSTER_ESSENTIALS_PATH=$TANZU_HOME_DIRECTORY/archives/essentials/$CLUSTER_ESSENTIALS_VERSION/tanzu-cluster-essentials-darwin-amd64-$CLUSTER_ESSENTIALS_VERSION.tgz

# Unpack the TAR file into the tanzu-cluster-essentials directory by running:
tar -xvf "$CLUSTER_ESSENTIALS_PATH" -C "$HOME"/tanzu-cluster-essentials

# Change the directory
cd "$HOME"/tanzu-cluster-essentials

./install.sh

sudo cp "$HOME"/tanzu-cluster-essentials/kapp /usr/local/bin/kapp
