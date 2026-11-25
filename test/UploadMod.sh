#!/usr/bin/env bash
set -euo pipefail

MOD_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
MOD_NAME="$(basename -- "$MOD_DIR")"
GAME_ROOT="$(cd -- "$MOD_DIR/../.." && pwd)"
STEAMAPPS_DIR="$(cd -- "$GAME_ROOT/../.." && pwd)"
COMPAT_DATA="$STEAMAPPS_DIR/compatdata/1611600"
PROTON_MOD="$COMPAT_DATA/pfx/drive_c/users/steamuser/Saved Games/EugenSystems/WARNO/mod/$MOD_NAME"

cd -- "$MOD_DIR"

if [[ ! -f "$PROTON_MOD/Config.ini" || ! -d "$PROTON_MOD/CommonData" || ! -d "$PROTON_MOD/GameData" ]]; then
	printf 'Generated mod files are missing from the game folder: %s\nRun GenerateMod.sh first.\n' "$PROTON_MOD" >&2
	exit 1
fi

if ! command -v steam >/dev/null 2>&1; then
	printf 'Steam launcher not found in PATH. Start Steam and install its command-line launcher.\n' >&2
	exit 1
fi

steam -applaunch 1611600 -headless -uploadmod "$MOD_NAME" CommonData:Clusters/Bootstrap/ClusterBootstrapUploadMod.ndf
printf 'Upload launch requested from Steam. Check WARNO for the result.\n'