# Create Tanzu Application Platform Install Environment Variables
export TAP_VERSION="1.4.0"
export TAP_NAMESPACE="tap-install"
export TAP_VALUES_FILE="tap-values.yaml"

TAP_VALUES_PATH=$HOME/tanzu/tap-values/${TAP_VERSION}/${TAP_VALUES_FILE}

INSTALL_REGISTRY_USERNAME=$(yq '.settings.installRegistry.username' env.yaml)
INSTALL_REGISTRY_PASSWORD=$(yq '.settings.installRegistry.password' env.yaml)
INSTALL_REGISTRY_HOSTNAME=$(yq '.settings.installRegistry.hostname' env.yaml)

REGISTRY_USERNAME=$(yq '.settings.registry.username' env.yaml)
REGISTRY_PASSWORD=$(yq '.settings.registry.password' env.yaml)
REGISTRY_SERVER=$(yq '.settings.registry.server' env.yaml)

if [[ -z "${INSTALL_REGISTRY_USERNAME}" ]]; then
    echo "Must provide INSTALL_REGISTRY_USERNAME in environment" 1>&2
    exit 1
fi

if [[ -z "${INSTALL_REGISTRY_PASSWORD}" ]]; then
    echo "Must provide INSTALL_REGISTRY_PASSWORD in environment" 1>&2
    exit 1
fi

if [[ -z "${INSTALL_REGISTRY_HOSTNAME}" ]]; then
    echo "Must provide INSTALL_REGISTRY_HOSTNAME in environment" 1>&2
    exit 1
fi

echo "docker logout"
docker logout

echo "docker login"
docker login europe-docker.pkg.dev -u "${REGISTRY_USERNAME}" -p "${REGISTRY_PASSWORD}"

kubectl create ns ${TAP_NAMESPACE}

tanzu secret registry add tap-registry \
  --username "${INSTALL_REGISTRY_USERNAME}" \
  --password "${INSTALL_REGISTRY_PASSWORD}" \
  --server "${INSTALL_REGISTRY_HOSTNAME}" \
  --namespace ${TAP_NAMESPACE} \
  --export-to-all-namespaces \
  --yes

tanzu secret registry add registry-credentials --username "${REGISTRY_USERNAME}" --password "${REGISTRY_PASSWORD}" --server "${REGISTRY_SERVER}" --namespace tap-install --export-to-all-namespaces

tanzu package repository add tanzu-tap-repository \
    --url "${INSTALL_REGISTRY_HOSTNAME}"/tanzu-application-platform/tap-packages:${TAP_VERSION} \
    --namespace ${TAP_NAMESPACE}

# Check for STATUS: “Reconcile succeeded”
tanzu package repository get tanzu-tap-repository --namespace ${TAP_NAMESPACE}

# Check for a big list of ready to use packages
tanzu package available list --namespace ${TAP_NAMESPACE}

tanzu package install tap -p tap.tanzu.vmware.com -v ${TAP_VERSION} \
  --values-file "${TAP_VALUES_PATH}" \
  --namespace ${TAP_NAMESPACE}