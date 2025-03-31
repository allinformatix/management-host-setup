#!/bin/bash
set -euo pipefail
source utils/common.sh
source utils/config.sh

log "🛠 Installiere Basis-Tools für CentOS..."
sudo yum install -y epel-release
sudo yum install -y \
  curl wget git unzip jq python3 python3-pip \
  gnupg2 ca-certificates lsb-release bash-completion net-tools docker

pip3 install --user ansible
export PATH="$HOME/.local/bin:$PATH"

install_if_missing brew "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\" && echo 'eval \"\$\(/home/linuxbrew/.linuxbrew/bin/brew shellenv\)\"' >> ~/.bashrc && eval \"\$\(/home/linuxbrew/.linuxbrew/bin/brew shellenv\)\""
install_if_missing kubectl "curl -LO https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/"
install_if_missing helm "curl -fsSL ${HELM_INSTALL_SCRIPT} | bash"
install_if_missing kubelogin "curl -Lo kubelogin https://github.com/int128/kubelogin/releases/download/${KUBELOGIN_VERSION}/kubelogin-linux-amd64 && chmod +x kubelogin && sudo mv kubelogin /usr/local/bin/"
install_if_missing mc "curl -O https://dl.min.io/client/mc/release/linux-amd64/mc && chmod +x mc && sudo mv mc /usr/local/bin/"
install_if_missing kubectx "git clone https://github.com/ahmetb/kubectx.git /tmp/kubectx && sudo cp /tmp/kubectx/kubectx /usr/local/bin/ && sudo cp /tmp/kubectx/kubens /usr/local/bin/ && sudo chmod +x /usr/local/bin/kubectx /usr/local/bin/kubens && rm -rf /tmp/kubectx"
install_if_missing k9s "curl -Lo k9s.tar.gz https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz && tar -xzf k9s.tar.gz k9s && chmod +x k9s && sudo mv k9s /usr/local/bin/ && rm k9s.tar.gz"
install_if_missing kustomize "brew install kustomize"
install_if_missing hcloud "brew install hcloud"
install_if_missing skaffold "brew install skaffold"
install_if_missing dsadm "echo 'Manuelle Installation von dsadm erforderlich oder Tool nicht mehr benötigt.'"

log "✅ CentOS Setup abgeschlossen."
