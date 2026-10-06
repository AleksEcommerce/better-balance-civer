-- Steel and Thunder: Unit Expansion: 5 niter to build a Gatling gun.
UPDATE Units SET StrategicResource = 'RESOURCE_NITER'
WHERE UnitType = 'UNIT_DLV_GATLING_GUN';

INSERT OR IGNORE INTO Units_XP2 (UnitType, ResourceCost)
SELECT UnitType, 5 FROM Units WHERE UnitType = 'UNIT_DLV_GATLING_GUN';

UPDATE Units_XP2 SET ResourceCost = 5
WHERE UnitType = 'UNIT_DLV_GATLING_GUN';
