-- Steel and Thunder: Unit Expansion: 15 niter to build a mortar.
UPDATE Units SET StrategicResource = 'RESOURCE_NITER'
WHERE UnitType = 'UNIT_DLV_MORTAR';

INSERT OR IGNORE INTO Units_XP2 (UnitType, ResourceCost)
SELECT UnitType, 15 FROM Units WHERE UnitType = 'UNIT_DLV_MORTAR';

UPDATE Units_XP2 SET ResourceCost = 15
WHERE UnitType = 'UNIT_DLV_MORTAR';
