#!/bin/bash

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

# Cluster essentials
TANZU_HOME_DIRECTORY=$HOME/tanzu
PATH_TANZU_CLI_TAR_FILE=$TANZU_HOME_DIRECTORY/archives/1.0.1/tanzu-framework-darwin-amd64.tar
CLUSTER_ESSENTIALS_PATH=$TANZU_HOME_DIRECTORY/archives/tanzu-cluster-essentials-darwin-amd64-1.0.0.tgz

export INSTALL_BUNDLE=registry.tanzu.vmware.com/tanzu-cluster-essentials/cluster-essentials-bundle@sha256:82dfaf70656b54dcba0d4def85ccae1578ff27054e7533d08320244af7fb0343

rm -rf "$HOME"/tanzu-cluster-essentials

mkdir -p "$HOME"/tanzu-cluster-essentials
tar -xvf "$CLUSTER_ESSENTIALS_PATH" -C "$HOME"/tanzu-cluster-essentials
cd "$HOME"/tanzu-cluster-essentials
./install.sh
sudo cp "$HOME"/tanzu-cluster-essentials/kapp /usr/local/bin/kapp

#Install or update the Tanzu CLI and plug-ins

# Remove old Tanzu CLI install
rm -rf "$HOME"/tanzu/cli        # Remove previously downloaded cli files
rm -rf ~/.config/tanzu/
rm -rf ~/.tanzu/
rm -rf ~/.cache/tanzu
rm -rf ~/Library/Application\ Support/tanzu-cli/* # Remove plug-ins

echo "Clean install Tanzu CLI"

echo
tar -xvf "$PATH_TANZU_CLI_TAR_FILE" -C $HOME/tanzu
cd "$HOME"/tanzu
export TANZU_CLI_NO_INIT=true
install cli/core/v0.11.1/tanzu-core-darwin_amd64 /usr/local/bin/tanzu
tanzu version

echo "tanzu update --local ./cli"
tanzu plugin sync

echo "tanzu version"
tanzu version
echo "tanzu plugin list"
tanzu plugin list
echo "rm -rf ~/Library/Application\ Support/tanzu-cli/*"
rm -rf ~/Library/Application\ Support/tanzu-cli/*

echo "tanzu plugin install --local cli all"
tanzu plugin install --local cli all

echo "tanzu plugin list"
tanzu plugin list
