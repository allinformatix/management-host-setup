#!/bin/bash
GREEN='\033[0;32m'
NC='\033[0m' # No Color

log() {
  echo -e "${GREEN}$1${NC}"
}

install_if_missing() {
  local cmd="$1"
  local installer="$2"

  if ! command -v "$cmd" &>/dev/null; then
    log "🔧 Installiere $cmd ..."
    eval "$installer"
  else
    log "✅ $cmd ist bereits installiert."
  fi
}
