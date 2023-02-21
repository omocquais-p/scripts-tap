#!/usr/bin/env bash

REGISTRY_USERNAME=$(yq '.settings.registry.username' env.yaml)
REGISTRY_PASSWORD=$(yq '.settings.registry.password' env.yaml)
REGISTRY_SERVER=$(yq '.settings.registry.server' env.yaml)

tanzu secret registry add registry-credentials --username "${REGISTRY_USERNAME}" --password "${REGISTRY_PASSWORD}" --server "${REGISTRY_SERVER}" --namespace tap-install --export-to-all-namespaces