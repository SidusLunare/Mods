# WARNO mod migration

After updating the game and its modding data, run this from inside your mod folder:

```sh
./MigrateMod.sh
```

The launcher automatically selects its own mod folder. To select a different mod, pass its name directly:

```sh
./MigrateMod.sh "M240 HE Change"
```

You can also run `./ModData/MigrateMod.sh` from the `Mods` folder to select a mod from a list. The launcher in `ModData` serves as a template for new mods; copy it into other existing mod folders as needed. By default the script only writes a report under `Mods/ModUpdateReports`; it does not change the mod. Provide an absolute path to a UTF-8 changelog with `--changelog /path/to/changelog.txt`. The changelog is included in the report for you or an AI assistant to review; it is not interpreted automatically.

Review the report, especially upstream changes affecting modded files. To apply a conflict-free migration, run:

```sh
./MigrateMod.sh --apply
```

The report includes line-by-line excerpts of upstream changes for NDF files present in both game versions. Lines starting with `-` are from the old baseline, and lines starting with `+` are from the new baseline. Mod-affected files appear first. Standard excerpts are limited to 200 lines and 20,000 characters per file, and 500,000 characters total. Other than the six gameplay files listed below, files larger than 512,000 bytes or 5,000 lines are omitted from text diffs to avoid slow comparisons. The report marks truncated or omitted diffs, which need separate review. Added and removed files are listed by path rather than shown in full, and moves or renames are not automatically detected.

`TacticalUnits.ndf`, `WeaponDescriptor.ndf`, `AmmunitionMissiles.ndf`, `Ammunition.ndf`, `Divisions.ndf`, and `DivisionRules.ndf` receive a separate excerpt budget of 2,000 lines or 200,000 bytes each. Their comparison requires the system `diff` command, and is limited to 64 MiB per source file and 30 seconds per file; failures and truncation are noted in the report. These limits affect the report only, not the migration or merge process.

After a successful apply, the script runs the selected mod's `GenerateMod.sh` to generate and install the updated mod. Use `./MigrateMod.sh --apply --no-generate` to skip generation and run it later. Analysis and blocked migrations never start generation.

The mod's `base.zip` is the clean baseline originally extracted into its editable `GameData` and `CommonData` folders. The script compares those actual folders against that baseline to identify mod edits, then compares it against `ModData/base.zip` to identify game updates. On apply, it writes merged NDF files and newly available NDF files into the mod's `GameData` and `CommonData` folders, not into an archive. It then copies the current clean `ModData/base.zip` over the mod's baseline so future updates can distinguish mod edits from game changes; the previous baseline is backed up. It does not generate an archive of your modded files.

The script retains files removed upstream and leaves previously missing files missing. It reports non-NDF changes for manual review. DLC data can only be detected if present in the updated `ModData/base.zip`; automatic merging does not guarantee gameplay compatibility or add new content to custom units or divisions.

If there are conflicts, nothing is applied. Candidate merges are saved under the report's `conflicts` folder: compare their conflict markers against the old base, the updated data and your mod changes. Resolve the mod's corresponding files and rerun the analysis before applying. Changes that merge without conflicts can still need manual attention, particularly when developer notes describe changed mechanics.

The merger preserves independent insertions from both sides. It also checks for potentially lost non-blank lines added by either side and blocks the entire apply if it detects any. A safety warning may be conservative; inspect the candidate and both original files before resolving it. This line-based check cannot guarantee that every change is preserved or that the merged game data is valid. Applying still replaces editable NDF files and the baseline archive, with the originals saved in the report's backup folder.

When game and mod changes insert recognizable single-line references, strings, or unit-ID pairs at the same position in an NDF list, both sets are kept across NDF files without checking for duplicates. Review duplicate units and IDs before generating the mod. Other overlapping additions, including multi-line definitions, may still require manual review. When a newly introduced game file has the same path as a different mod file, there is no common baseline to merge against; the apply is blocked and the upstream file is saved in the report's `conflicts` folder for comparison with the mod file.

Every successful apply stores the previous `base.zip` and overwritten files in the report's `backup` folder. `created-files.txt` lists files introduced by the migration. To undo an update, restore the backed-up files and base archive into the mod and remove the listed created files, taking care not to discard subsequent edits. If generation fails, the migration remains applied and the script exits with status 3; fix the error and run the mod's `GenerateMod.sh` again. Generation may have partially changed its output, so do not assume the playable mod was updated. Test the mod in game after generation. This script does not replace the official updater's other housekeeping.

Python 3.9 or later and Bash are required. The mod must be a direct child of the `Mods` folder with its original `base.zip` intact.