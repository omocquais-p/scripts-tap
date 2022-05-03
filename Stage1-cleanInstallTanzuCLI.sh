#!/bin/bash

set -e

# Stage 1: Download and Install the Tanzu CLI.

TAP_VERSION=1.1.0
TANZU_CLI_VERSION=v0.11.2

echo "TAP_VERSION:$TAP_VERSION TANZU_CLI_VERSION:$TANZU_CLI_VERSION"

# Tanzu directory
TANZU_HOME_DIRECTORY=$HOME/tanzu

# Tanzu CLI
PATH_TANZU_CLI_TAR_FILE=$TANZU_HOME_DIRECTORY/archives/$TAP_VERSION/tanzu-framework-darwin-amd64.tar

#Install or update the Tanzu CLI and plug-ins

# Remove old Tanzu CLI install
rm -rf "$HOME"/tanzu/cli        # Remove previously downloaded cli files
rm -rf ~/.config/tanzu/
rm -rf ~/.tanzu/
rm -rf ~/.cache/tanzu
rm -rf ~/Library/Application\ Support/tanzu-cli/* # Remove plug-ins

echo "Clean install Tanzu CLI"

echo
tar -xvf "$PATH_TANZU_CLI_TAR_FILE" -C "$HOME"/tanzu
cd "$HOME"/tanzu
export TANZU_CLI_NO_INIT=true
install cli/core/$TANZU_CLI_VERSION/tanzu-core-darwin_amd64 /usr/local/bin/tanzu
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
