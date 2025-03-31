#!/bin/bash

# Versionen zentral verwalten
KUBECTL_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
HELM_INSTALL_SCRIPT="https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3"
KUBELOGIN_VERSION=$(curl -s https://api.github.com/repos/int128/kubelogin/releases/latest | jq -r .tag_name)
K9S_VERSION="v0.32.4"