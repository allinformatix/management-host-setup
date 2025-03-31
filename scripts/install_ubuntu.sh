#!/bin/bash
set -euo pipefail
source utils/common.sh

# Versionen definieren
KUBECTL_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
HELM_INSTALL_SCRIPT="https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3"
KUBELOGIN_VERSION=$(curl -s https://api.github.com/repos/int128/kubelogin/releases/latest | jq -r .tag_name)
K9S_VERSION="v0.32.4"
FORGEOPS_CLI_VERSION="7.4.0"

log "🔄 System aktualisieren..."
sudo apt update && sudo apt upgrade -y

log "🛠 Installiere Basis-Tools..."
sudo apt install -y \
  curl wget gnupg2 lsb-release apt-transport-https \
  ca-certificates software-properties-common \
  git unzip jq python3 python3-pip bash-completion net-tools

log "📦 Installiere Ansible..."
sudo apt install -y ansible

log "📦 Installiere kubectl ($KUBECTL_VERSION)..."
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" || exit 1
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

log "📦 Installiere Helm..."
curl -fsSL "$HELM_INSTALL_SCRIPT" | bash || exit 1

log "📦 Installiere kubelogin ($KUBELOGIN_VERSION)..."
curl -Lo kubelogin "https://github.com/int128/kubelogin/releases/download/${KUBELOGIN_VERSION}/kubelogin-linux-amd64" || exit 1
chmod +x kubelogin
sudo mv kubelogin /usr/local/bin/

log "📦 Installiere mc (S3 client)..."
curl -O https://dl.min.io/client/mc/release/linux-amd64/mc || exit 1
chmod +x mc
sudo mv mc /usr/local/bin/

log "📦 Installiere kubectx und kubens..."
git clone https://github.com/ahmetb/kubectx.git /tmp/kubectx || exit 1
sudo cp /tmp/kubectx/kubectx /usr/local/bin/
sudo cp /tmp/kubectx/kubens /usr/local/bin/
sudo chmod +x /usr/local/bin/kubectx /usr/local/bin/kubens
rm -rf /tmp/kubectx

log "📦 Installiere k9s ($K9S_VERSION)..."
curl -Lo k9s.tar.gz https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz || exit 1
tar -xzf k9s.tar.gz k9s
chmod +x k9s
sudo mv k9s /usr/local/bin/
rm k9s.tar.gz

log "📦 Installiere ForgeOps CLI (dsadm)..."
curl -Lo dsadm.zip https://backstage.forgerock.com/downloads/file/forgeops/${FORGEOPS_CLI_VERSION}/dsadm.zip || exit 1
unzip dsadm.zip -d dsadm
sudo mv dsadm/dsadm /usr/local/bin/
sudo chmod +x /usr/local/bin/dsadm
rm -rf dsadm dsadm.zip

log "✅ Ubuntu Setup abgeschlossen."
