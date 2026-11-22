#!/usr/bin/env bash
set -euo pipefail

MOD_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
MOD_NAME="$(basename -- "$MOD_DIR")"
GAME_ROOT="$(cd -- "$MOD_DIR/../.." && pwd)"
STEAMAPPS_DIR="$(cd -- "$GAME_ROOT/../.." && pwd)"
STEAM_ROOT="$(dirname -- "$STEAMAPPS_DIR")"
COMPAT_DATA="$STEAMAPPS_DIR/compatdata/1611600"
GENERATED_MOD="$HOME/.config/EugenSystems/WARNO/saves/mod/$MOD_NAME"
PROTON_MOD="$COMPAT_DATA/pfx/drive_c/users/steamuser/Saved Games/EugenSystems/WARNO/mod/$MOD_NAME"

cd -- "$MOD_DIR"
export WINEPREFIX="$COMPAT_DATA/pfx"
export STEAM_COMPAT_DATA_PATH="$COMPAT_DATA"
export STEAM_COMPAT_CLIENT_INSTALL_PATH="$STEAM_ROOT"
export STEAM_COMPAT_INSTALL_PATH="$GAME_ROOT"
export SteamAppId=1611600 SteamGameId=1611600
python3 "$MOD_DIR/../Utils/Scripts/GenerateMod.py" WARNO "$MOD_NAME"

if [[ ! -d "$GENERATED_MOD" || ! -f "$GENERATED_MOD/Config.ini" ]]; then
	printf 'Generated mod data or its per-mod Config.ini is missing.\n' >&2
	exit 1
fi

mkdir -p -- "$PROTON_MOD"
cp -a -- "$GENERATED_MOD/." "$PROTON_MOD/"

if [[ ! -f "$PROTON_MOD/Config.ini" ]]; then
	printf 'Per-mod Config.ini was not copied to the Proton mod folder.\n' >&2
	exit 1
fi
