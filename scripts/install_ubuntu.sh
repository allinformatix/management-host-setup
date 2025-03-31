#!/bin/bash
set -euo pipefail
source utils/common.sh

log "🔄 System aktualisieren..."
sudo apt update && sudo apt upgrade -y

log "🛠 Installiere Basis-Tools..."
sudo apt install -y \
  curl wget gnupg2 lsb-release apt-transport-https \
  ca-certificates software-properties-common \
  git unzip jq python3 python3-pip

log "📦 Installiere Ansible..."
sudo apt install -y ansible

log "📦 Installiere kubectl..."
KUBECTL_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

log "📦 Installiere Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

log "📦 Installiere kubelogin..."
KUBELOGIN_VERSION=$(curl -s https://api.github.com/repos/int128/kubelogin/releases/latest | jq -r .tag_name)
curl -Lo kubelogin "https://github.com/int128/kubelogin/releases/download/${KUBELOGIN_VERSION}/kubelogin-linux-amd64"
chmod +x kubelogin
sudo mv kubelogin /usr/local/bin/

log "📦 Installiere mc..."
curl -O https://dl.min.io/client/mc/release/linux-amd64/mc
chmod +x mc
sudo mv mc /usr/local/bin/

log "📦 Installiere kubectx und kubens..."
git clone https://github.com/ahmetb/kubectx.git /tmp/kubectx
sudo cp /tmp/kubectx/kubectx /usr/local/bin/
sudo cp /tmp/kubectx/kubens /usr/local/bin/
sudo chmod +x /usr/local/bin/kubectx /usr/local/bin/kubens
rm -rf /tmp/kubectx

log "✅ Ubuntu Setup abgeschlossen."
