# Swedish unit migration checklist

This checklist covers the 19 Swedish unit descriptors copied from the old mod's `GameData/Generated/Gameplay/Gfx/UniteDescriptor.ndf` into this mod's `GameData/Generated/Gameplay/TacticalUnits.ndf`. All 19 are custom names absent from the old clean baseline. Namespace updates have started, but the descriptors are not yet fully migrated or tested in game.

## Shared descriptor review

The following legacy patterns were found in all 19 copied units. Current-format examples were observed in the new tactical unit file, but each replacement still needs validation for the relevant unit type.

- [x] Replace old `ECoalition/...` namespace with `TWargameCoalition/...`, preserving each unit's existing coalition.
- [x] Replace old `EFactory/...` namespace with `Factory/...`, preserving each unit's factory category.
- [x] Confirmed the intended coalitions: all 19 units are `NATO`. `Kapjas_m65_SWE` and `Howz_Haubits_m4140_SWE` were changed from the old accidental `PACT` value to `NATO`.
- [x] Replaced `$/GFX/UnitConstantes/CriticalEffectModule_...` with `$/GFX/CriticalEffects/CriticalEffectModule_...` in all 19 units.
- [x] Replaced `BlackHoleIdentifier` and `ShowRoomBlackHoleIdentifier` as applicable with `BlackHoleKey` and preserved identifier values.
- [x] Replaced `UnitCadavreGeneratorModuleDescriptor`, `CadavreDuration` and `CadavreDurationApresFeu` with current `Cadaver` spellings in all 19 units.
- [x] Replaced `UnitStateEngineCompanyModuleDescriptor` and `UnitStateEngineModuleDescriptor` with `UnitStateEngineUnitModuleDescriptor` and `UnitStateEngineSubUnitModuleDescriptor` in all 19 units.
- [x] Removed the 19 old `TCubeActionModuleDescriptor` blocks because no corresponding module remains in the copied current-format section; in-game behavior still needs testing.
- [x] Replaced all 19 scanner/optics sets with the matched stock-reference values: ordinary units 1590/1590/353, command units 3180/3180/706, helicopter 2473/2473/1413, reconnaissance 5300/5300/1413, and Kapjas_m65_SWE 3180/3180/1413. These values still need in-game validation.
- [x] Audited appearance/model references for all 19 units: all use existing stock mimetic names, reference meshes, BlackHole keys, tactical textures, button textures and availability descriptors found in the new data. Only `Kapjas_m65_SWE` needs availability review: it uses the KSM65 appearance but the L118 105 mm availability descriptor. Production cost, supply, tags, GUID and gameplay settings remain separate validation items.
- [ ] Check each unit's appearance, model, textures, localization tokens, production cost, supply, vision, tags, availability, GUID and gameplay settings. Preserve intentional custom values unless an incompatible schema requires a change.

The 18 land units now use `WheelVehicleTerrainSpeedFactors` or `InfantryTerrainSpeedFactors` instead of `TerrainSpeedModifierModuleDescriptor`: 12 are wheel units and six are infantry-type units. The helicopter requires a separate air-movement comparison. Nine armed units contain `TargetManagerModuleDescriptor`; compare appropriate current armed units before changing it.

The 19 unit GUIDs were unique within the current `TacticalUnits.ndf` at the time of this audit. This does not check other files or guarantee the GUIDs are valid across the whole mod.

A recovery backup is available at `GameData/Generated/Gameplay/TacticalUnits.ndf.pre-swedish-recovery`.

## Per-unit checklist

Each item requires the shared review above, a comparison with an appropriate current unit, and validation of referenced assets and unit behavior. Weapon references below were checked only against the new mod's `GameData/Generated/Gameplay/Gfx/WeaponDescriptor.ndf`; a missing definition there is not proof it is absent everywhere.

- [ ] `Tgb_311A_Supply_SWE`: wheeled supply; no weapon descriptor reference found.
- [ ] `Tgb_411B_Moelven_Supply_SWE`: wheeled supply; no weapon descriptor reference found.
- [ ] `Hjtrak_319V_Trakk_3T_SWE`: wheeled supply; no weapon descriptor reference found.
- [ ] `Raptgb_9033_CMD_SWE`: wheeled command; no weapon descriptor reference found.
- [ ] `StabsTgb_m42A_CMD_SWE`: wheeled command; `WeaponDescriptor_StabsTgb_m42A_CMD_SWE` not found in the current weapon file.
- [ ] `81mm_Mortar_Grk_m2939`: infantry-type movement; `WeaponDescriptor_81mm_Mortar_Grk_m2939` not found in the current weapon file. This unit's descriptor name has no `_SWE` suffix.
- [ ] `Ltgb_934F_trans_SWE`: wheeled transport; no weapon descriptor reference found.
- [ ] `Tgb_m42A_trans_SWE`: wheeled transport; `WeaponDescriptor_Tgb_m42A_CMD_SWE` not found in the current weapon file; verify that this command-named weapon is the intended one. The copied unit uses the `Tanks` factory category; review rather than silently changing it.
- [ ] `Pltgb_903_SWE`: wheeled transport; no weapon descriptor reference found.
- [ ] `Hjtrak_319V_PTP_SWE`: wheeled transport; no weapon descriptor reference found.
- [ ] `PV444_MP_SWE`: wheeled transport; no weapon descriptor reference found.
- [ ] `TGB_40_trans_SWE`: wheeled transport; no weapon descriptor reference found.
- [ ] `HKP_4_SWE`: helicopter; no weapon descriptor reference found; review air movement separately.
- [ ] `Pltgb_903_Ksp_SWE`: wheeled reconnaissance; `WeaponDescriptor_Pltgb_903_Ksp_SWE` not found in the current weapon file.
- [ ] `120mm_Mortar_Grk_m62_SWE`: infantry-type movement; `WeaponDescriptor_Mortier_120mm_L65_ESP` is present in the current weapon file; check its current behavior and ammunition.
- [ ] `Mortar_Minrojningsorm_1_SWE`: infantry-type movement; `WeaponDescriptor_Mortar_Minrojningsorm_1_SWE` not found in the current weapon file.
- [ ] `Kapjas_m65_SWE`: infantry-type movement; `WeaponDescriptor_Kapjas_m65_SWE` not found in the current weapon file.
- [ ] `Howz_Haubits_m40_SWE`: infantry-type movement; `WeaponDescriptor_Howz_Haubits_m40_SWE` not found in the current weapon file.
- [ ] `Howz_Haubits_m4140_SWE`: infantry-type movement; `WeaponDescriptor_Howz_Haubits_m4140_SWE` not found in the current weapon file.

## Dependencies and validation

- [x] Migrated eight custom weapon-manager blocks and identified the four Kapjas ammunition modes plus HE/smoke and KSP ammo dependencies.
- [ ] Verify all referenced models, depictions, icons, sound references and localization tokens exist and are accessible under the current game namespaces.
- [ ] Check Sweden country/coalition definitions, division rules, unit availability, transport relationships and deck/serializer registrations against the new version.
- [x] Checked custom unit-to-weapon references: all nine custom/Swedish weapon references used by the unit descriptors have exactly one declaration in the weapon file.
- [ ] Run WARNO generation and address actual NDF errors after dependencies have been migrated. Generation has not been run as part of this audit.
- [ ] Test all 19 units in game, including movement, vision, selection, weapons, ammunition, supply, transport, visuals and localization as applicable.

## Weapon and ammunition migration

The old weapon and ammunition format differs substantially from the current format. Preserve Swedish role-specific ammo, damage, range and firing behavior, but migrate display metadata and mounted-weapon fields separately.

### Current-format ammunition checks

- [ ] Remove old UI metadata from each custom ammunition descriptor: `Name`, `TypeCategoryName`, `Caliber`, `WeaponDescriptionToken`, `TraitsToken`, `InterfaceWeaponTexture`.
- [x] Verified that all 1,425 weapon ammunition references resolve in `Ammunition.ndf` or `AmmunitionMissiles.ndf`; these files must both be searched for missing-name checks.
- [ ] Preserve ammunition gameplay fields: weapon cursor, min/max category, damage family, projectile type, ranges, dispersion, damage/suppression, salvo timing, supply cost, indirect-fire flags and smoke/fire/destruction behavior.
- [ ] Preserve `DescriptorId` values unless a collision or tool-generated replacement is intentionally required.
- [ ] Check `EBaseHitValueModifier` fields in infantry sniper ammunition and add explicit `Base`, `Idling`, `Moving`, and `Targeted` entries where required.
- [ ] Check `SpeedGRU`, `FluidFriction`, `CorrectedShotDispersionMultiplier`, `HasDeploymentTime`, `TirIndirect`, and `TirReflexe` against current ammunition examples of the same role.
- [ ] Migrate the 120 mm mortar HE/smoke pair and 81 mm mortar HE/smoke pair as old/new ammunition counterparts.
- [ ] Migrate the Kapjas HE, smoke, direct-fire and AA ammunition using its existing `Ammo_Howz_Canon_Kapjas_m65_SWE*` set as one four-ammunition group.
- [ ] Migrate the Haubits m/40 HE/smoke pair and Haubits m/41-40 HE/smoke/direct pair.
- [ ] Migrate `Ammo_Mortar_Minrojninsorm_1_SWE`, `Ammo_MMG_ksp_m58_7_62mm`, and all unit-referenced Swedish ammunition added to `Ammunition.ndf`.

### Current-format weapon-manager checks

- [x] Replaced/verified `AmmoBoxIndex` for all 19 custom mounted ammunition references; no custom `SalvoStockIndex` entries remain.
- [x] Added conservative `SalvoIsMainSalvo` arrays to the four custom multi-salvo manager groups; Kapjas and Haubits/MI values remain deferred until stock-role comparison and generation.
- [ ] Add `SalvoIsMainSalvo` beside `Salves` when the custom weapon has multiple ammunition groups or main/direct/secondary roles.
- [ ] Add the following fields to each `TMountedWeaponDescriptor` when present in the corresponding new ammunition: `Caliber`, `InterfaceWeaponTexture`, `Name`, `TraitsToken`, `TypeCategoryName`, and `WeaponDescriptionToken`.
- [ ] Use lowercase booleans for new-format fields.
- [ ] Preserve `Ammunition`, `EffectTag`, `HandheldEquipmentKey`, weapon-active/ignored properties, shoot-data properties, animation, turret and display settings unless current-generation syntax requires a change.
- [ ] Keep the Kapjas's HE, smoke, direct-fire and AA ammunition in separate distinct ammo boxes while the tri-role weapon behavior remains unfinished.
- [ ] Compare command/KSP weapon, reconnaissance weapon, 81 mm mortar, 120 mm mortar, Minröjningsorm, Haubits and Kapjas against stock new-format managers of the same role.
- [ ] Verify each current `TMountedWeaponDescriptor` points to an existing custom or stock ammunition name.
- [ ] Verify no custom weapon manager contains obsolete `SalvoStockIndex` entries after migration.

### Kapjas deferred tri-role work

- [ ] Match the KSM65 100 mm appearance and preserve the L118 105 mm availability descriptor.
- [ ] Keep the Kapjas direct-fire ammunition and HE artillery ammunition separate.
- [ ] Add or verify the AA firing ammunition and ranges in the same weapon manager.
- [ ] Decide how smoke is represented in the final four/ammunition/salvo layout.
- [ ] Do not mark the Kapjas weapon complete until direct, howitzer and AA roles are all usable and generation succeeds.

## Mortar/howitzer deployment and pack-up

- [ ] Add deployment behavior to all Swedish mortar/howitzer ammunition and unit descriptors.
- [ ] Mortars: use `Mortier_M29_81mm_NL` and `Mortier_81mm_L65_ESP` as deployment references. Copy the exact current `HasDeploymentTime` and deployment-shift setup appropriate to their category; apply it to 81 mm, 120 mm and Minröjningsorm units.
- [ ] Howitzers: use `Howz_M101_105mm_NL` and `Howz_D30_122mm_DDR` as deployment references. Apply the same current deployment/pack-up pattern to the m/40 and m/41-40 howitzers.
- [ ] Preserve current Swedish weapon modes while adding deployment and pack-up fields; do not substitute mortar or howitzer categories without checking ammunition role.