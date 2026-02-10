#!/usr/bin/env bash
set -e

export STEAM_COMPAT_DATA_PATH="/home/novavdv/.steam/steam/steamapps/compatdata/1611600"
export STEAM_COMPAT_CLIENT_INSTALL_PATH="/home/novavdv/.steam/steam"

GAME_NAME="WARNO"

# Absolute path to the directory this script is in
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Folder name only (mod name)
CurrDirName="$(basename "$SCRIPT_DIR")"

# Move to script directory (important for relative paths)
cd "$SCRIPT_DIR"

PROTON_RUN="/home/novavdv/.steam/steam/steamapps/common/Proton 9.0 (Beta)/proton"
"$PROTON_RUN" run ../../WARNO.exe -headless -uploadmod "$CurrDirName" \
  CommonData:Clusters/Bootstrap/ClusterBootstrapUploadMod.ndf
