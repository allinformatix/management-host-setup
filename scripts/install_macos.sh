#!/bin/bash
set -euo pipefail
source utils/common.sh

log "📦 Installiere Homebrew-basierte Tools..."
which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install ansible kubectl helm jq git minio/stable/mc k9s
brew tap ahmetb/kubectx
brew install kubectx
brew install --cask iterm2

log "✅ macOS Setup abgeschlossen."
