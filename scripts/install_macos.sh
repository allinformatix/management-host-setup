#!/bin/bash
set -euo pipefail
source utils/common.sh
source utils/config.sh

log "📦 Stelle sicher, dass Homebrew vorhanden ist..."
install_if_missing brew "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""

brew update
brew install kubectl helm kubectx kustomize hcloud skaffold k9s jq git ansible python3
brew install --cask iterm2

log "✅ macOS Setup abgeschlossen."
