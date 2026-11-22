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
PREFIX_VERSION="$(<"$COMPAT_DATA/version")"
PROTON="${WARNO_PROTON:-}"

if [[ -z "$PROTON" ]]; then
	for candidate in "$STEAMAPPS_DIR"/common/*/proton "$STEAM_ROOT"/compatibilitytools.d/*/proton; do
		[[ -x "$candidate" ]] || continue
		if grep -Fq "CURRENT_PREFIX_VERSION=\"$PREFIX_VERSION\"" "$candidate"; then
			PROTON="$candidate"
			break
		fi
	done
fi

if [[ ! -x "$PROTON" ]]; then
	printf 'Could not find a Proton launcher matching prefix version %s.\nSet WARNO_PROTON to its executable path.\n' "$PREFIX_VERSION" >&2
	exit 1
fi

cd -- "$MOD_DIR"
export WARNO_PROTON="$PROTON"
export STEAM_COMPAT_DATA_PATH="$COMPAT_DATA"
export STEAM_COMPAT_CLIENT_INSTALL_PATH="$STEAM_ROOT"
export STEAM_COMPAT_INSTALL_PATH="$GAME_ROOT"
export SteamAppId=1611600 SteamGameId=1611600
python3 "$MOD_DIR/../Utils/Scripts/GenerateMod.py" WARNO "$MOD_NAME"

if [[ ! -d "$GENERATED_MOD" || ! -f "$PROTON_MOD/Config.ini" ]]; then
	printf 'Generated mod data or Proton mod configuration is missing.\n' >&2
	exit 1
fi

mkdir -p -- "$PROTON_MOD"
cp -a -- "$GENERATED_MOD/." "$PROTON_MOD/"