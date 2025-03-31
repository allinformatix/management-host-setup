#!/bin/bash
set -euo pipefail
source utils/common.sh

log "🛠 Installiere Basis-Tools für CentOS..."
sudo yum install -y epel-release
sudo yum install -y \
  curl wget git unzip jq python3 python3-pip \
  gnupg2 ca-certificates lsb-release bash-completion net-tools

pip3 install --user ansible
export PATH="$HOME/.local/bin:$PATH"

log "Bitte manuell die kubectl/helm/mc/kubectx Installation nach Vorlage Ubuntu ergänzen."
log "✅ CentOS Setup abgeschlossen."
