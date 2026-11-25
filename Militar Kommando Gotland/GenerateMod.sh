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

CONFIG_BACKUP_DIR="$(mktemp -d)"
CONFIG_BACKUP=""
HAD_PROTON_CONFIG=0
if [[ -f "$PROTON_MOD/Config.ini" ]]; then
	HAD_PROTON_CONFIG=1
	cp -p -- "$PROTON_MOD/Config.ini" "$CONFIG_BACKUP_DIR/Config.ini"
	CONFIG_BACKUP="$CONFIG_BACKUP_DIR/Config.ini"
elif [[ -f "$GENERATED_MOD/Config.ini" ]]; then
	cp -p -- "$GENERATED_MOD/Config.ini" "$CONFIG_BACKUP_DIR/Config.ini"
	CONFIG_BACKUP="$CONFIG_BACKUP_DIR/Config.ini"
fi
restore_config() {
	if [[ "$HAD_PROTON_CONFIG" == 1 ]]; then
		cp -p -- "$CONFIG_BACKUP" "$PROTON_MOD/Config.ini"
	fi
	rm -f -- "$CONFIG_BACKUP_DIR/Config.ini"
	rmdir -- "$CONFIG_BACKUP_DIR"
}
trap restore_config EXIT

python3 "$MOD_DIR/../Utils/Scripts/GenerateMod.py" WARNO "$MOD_NAME"

if [[ ! -d "$GENERATED_MOD" || ! -f "$PROTON_MOD/Config.ini" ]]; then
	printf 'Generated mod data or the game-generated Proton Config.ini is missing.\n' >&2
	exit 1
fi

mkdir -p -- "$PROTON_MOD"
shopt -s dotglob nullglob
for item in "$GENERATED_MOD"/*; do
	[[ "${item##*/}" == Config.ini ]] && continue
	cp -a -- "$item" "$PROTON_MOD/"
done
python3 "$MOD_DIR/../Utils/Scripts/UpdateGeneratedConfig.py" "$PROTON_MOD/Config.ini" "$GENERATED_MOD/Config.ini" "$CONFIG_BACKUP" "$MOD_DIR/Gen/DataPackerConfig.ndf"
trap - EXIT
rm -f -- "$CONFIG_BACKUP_DIR/Config.ini"
rmdir -- "$CONFIG_BACKUP_DIR"
