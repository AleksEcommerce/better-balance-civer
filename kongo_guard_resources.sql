-- Kongo Republican Guard: same strategic resource rules as Australian SASR.
UPDATE Units SET StrategicResource = 'RESOURCE_NITER'
WHERE UnitType = 'UNIT_KONGO_GARDE_REPUBLICAINE';

INSERT OR IGNORE INTO Units_XP2 (UnitType)
SELECT UnitType FROM Units WHERE UnitType = 'UNIT_KONGO_GARDE_REPUBLICAINE';

UPDATE Units_XP2
SET ResourceCost = 10,
    ResourceMaintenanceType = 'RESOURCE_OIL',
    ResourceMaintenanceAmount = 1
WHERE UnitType = 'UNIT_KONGO_GARDE_REPUBLICAINE';
