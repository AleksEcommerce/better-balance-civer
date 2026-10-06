-- Unique replacements inherit the normal tank's strategic resource rules.
-- Run after resource rebalances and civilization/unit mods.
UPDATE Units
SET StrategicResource = (SELECT StrategicResource FROM Units WHERE UnitType = 'UNIT_TANK')
WHERE UnitType IN (SELECT CivUniqueUnitType FROM UnitReplaces WHERE ReplacesUnitType = 'UNIT_TANK');

INSERT OR IGNORE INTO Units_XP2 (UnitType)
SELECT UnitType FROM Units
WHERE UnitType IN (SELECT CivUniqueUnitType FROM UnitReplaces WHERE ReplacesUnitType = 'UNIT_TANK');

UPDATE Units_XP2
SET ResourceCost = (SELECT ResourceCost FROM Units_XP2 WHERE UnitType = 'UNIT_TANK'),
    ResourceMaintenanceType = (SELECT ResourceMaintenanceType FROM Units_XP2 WHERE UnitType = 'UNIT_TANK'),
    ResourceMaintenanceAmount = (SELECT ResourceMaintenanceAmount FROM Units_XP2 WHERE UnitType = 'UNIT_TANK')
WHERE UnitType IN (SELECT CivUniqueUnitType FROM UnitReplaces WHERE ReplacesUnitType = 'UNIT_TANK')
  AND EXISTS (SELECT 1 FROM Units_XP2 WHERE UnitType = 'UNIT_TANK');
