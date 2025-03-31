# Management Host Setup

Dieses Repository enthält ein plattformübergreifendes Setup-Skript zur Vorbereitung eines Management-Hosts für Kubernetes- und DevOps-Projekte.

## Unterstützte Plattformen
- Ubuntu (inkl. WSL)
- CentOS / RHEL
- macOS (Apple Silicon & Intel)

## Projekt Struktur
```
management-host-setup/
├── README.md
├── install.sh
├── scripts/
│   ├── install_ubuntu.sh
│   ├── install_centos.sh
│   ├── install_macos.sh
│   ├── install_wsl.sh
├── utils/
│   └── common.sh
```

## Nutzung
```bash
bash install.sh
```