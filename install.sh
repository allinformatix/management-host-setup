#!/bin/bash
set -euo pipefail

OS=$(uname | tr '[:upper:]' '[:lower:]')

if grep -qi microsoft /proc/version 2>/dev/null; then
  echo "➡️  WSL erkannt"
  bash scripts/install_wsl.sh
elif [[ "$OS" == "linux" ]]; then
  if [ -f /etc/centos-release ]; then
    bash scripts/install_centos.sh
  elif [ -f /etc/lsb-release ] || [ -f /etc/debian_version ]; then
    bash scripts/install_ubuntu.sh
  else
    echo "❌ Nicht unterstütztes Linux-System"
    exit 1
  fi
elif [[ "$OS" == "darwin" ]]; then
  bash scripts/install_macos.sh
else
  echo "❌ Nicht unterstütztes Betriebssystem"
  exit 1
fi
