#!/bin/bash
set -euo pipefail
source utils/common.sh

log "🔍 WSL erkannt – leite weiter auf Ubuntu-Setup..."
bash scripts/install_ubuntu.sh
