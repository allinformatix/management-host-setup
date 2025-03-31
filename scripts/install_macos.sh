#!/bin/bash
set -euo pipefail
source utils/common.sh

log "📦 Installiere Homebrew-basierte Tools..."
which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install ansible kubectl helm minio/stable/mc jq git
brew install --cask iterm2

brew tap ahmetb/kubectx
brew install kubectx

log "✅ macOS Setup abgeschlossen."
