#!/usr/bin/env bash
set -euo pipefail

MOD_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd -- "$MOD_DIR"
exec python3 "$MOD_DIR/../Utils/Scripts/MigrateMod.py" "$@"