#!/bin/bash
set -euo pipefail
source utils/common.sh

REQUIRED_TOOLS=(
  kubectl
  helm
  kubelogin
  mc
  kubectx
  kubens
  k9s
  jq
  git
  ansible
  python3
  kustomize
  hcloud
  docker
  skaffold
  brew
)

log "🔍 Überprüfe installierte Tools..."

for tool in "${REQUIRED_TOOLS[@]}"; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    echo "❌ $tool nicht gefunden."
  else
    echo -n "✅ $tool: "
    "$tool" --version 2>/dev/null || echo "[Version nicht verfügbar]"
  fi
  echo
done

log "🛠 Überprüfung abgeschlossen. Nicht installierte Tools können mit dem Setup installiert werden."
