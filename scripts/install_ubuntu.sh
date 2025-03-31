#!/bin/bash
set -euo pipefail
source utils/common.sh
source utils/config.sh

log "🔄 System aktualisieren..."
sudo apt update && sudo apt upgrade -y

log "🛠 Installiere Basis-Tools..."
sudo apt install -y \
  curl wget gnupg2 lsb-release apt-transport-https \
  ca-certificates software-properties-common \
  git unzip jq python3 python3-pip bash-completion net-tools

if ! command -v docker >/dev/null 2>&1; then
  log "🐳 Installiere Docker von get.docker.com..."
  curl -fsSL https://get.docker.com | sudo bash
else
  log "✅ Docker ist bereits installiert."
fi

log "📦 Installiere Homebrew (falls benötigt)..."
if ! command -v brew >/dev/null 2>&1; then
  NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  BREW_PATH="$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  echo "eval \"$BREW_PATH\"" >> ~/.bashrc
  eval "$BREW_PATH"
  log "✅ brew wurde installiert."
else
  log "✅ brew ist bereits vorhanden."
fi

# Aktuelle Versionen ermitteln
KUBECTL_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
KUBELOGIN_VERSION=$(curl -s https://api.github.com/repos/int128/kubelogin/releases/latest | jq -r .tag_name)
K9S_VERSION=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | jq -r .tag_name)

install_if_missing kubectl "curl -LO https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/"
install_if_missing helm "curl -fsSL ${HELM_INSTALL_SCRIPT} | bash"
install_if_missing kubelogin "curl -Lo kubelogin https://github.com/int128/kubelogin/releases/download/${KUBELOGIN_VERSION}/kubelogin-linux-amd64 && chmod +x kubelogin && sudo mv kubelogin /usr/local/bin/"
install_if_missing mc "curl -O https://dl.min.io/client/mc/release/linux-amd64/mc && chmod +x mc && sudo mv mc /usr/local/bin/"
install_if_missing kubectx "git clone https://github.com/ahmetb/kubectx.git /tmp/kubectx && sudo cp /tmp/kubectx/kubectx /usr/local/bin/ && sudo cp /tmp/kubectx/kubens /usr/local/bin/ && sudo chmod +x /usr/local/bin/kubectx /usr/local/bin/kubens && rm -rf /tmp/kubectx"
install_if_missing k9s "curl -Lo k9s.tar.gz https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz && tar -xzf k9s.tar.gz k9s && chmod +x k9s && sudo mv k9s /usr/local/bin/ && rm k9s.tar.gz"
install_if_missing kustomize "brew install kustomize"
install_if_missing hcloud "brew install hcloud"
install_if_missing skaffold "brew install skaffold"
install_if_missing ansible "sudo apt install -y ansible"

log "✅ Ubuntu Setup abgeschlossen."
