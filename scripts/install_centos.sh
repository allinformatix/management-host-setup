#!/bin/bash
set -euo pipefail
source utils/common.sh

log "🛠 Installiere Basis-Tools für CentOS..."
sudo yum install -y epel-release
sudo yum install -y \
  curl wget git unzip jq python3 python3-pip \
  gnupg2 ca-certificates lsb-release

# Ansible via pip für mehr Kompatibilität
pip3 install --user ansible
export PATH="$HOME/.local/bin:$PATH"

# Der Rest analog zu Ubuntu...
log "Bitte manuell die kubectl/helm/mc/kubectx Installation nach Vorlage Ubuntu ergänzen."
log "✅ CentOS Setup abgeschlossen."
