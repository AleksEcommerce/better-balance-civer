-- Steel and Thunder: Unit Expansion: 40 niter to build self-propelled artillery.
UPDATE Units SET StrategicResource = 'RESOURCE_NITER'
WHERE UnitType = 'UNIT_DLV_SELF_PROPELLED_ARTILLERY';

INSERT OR IGNORE INTO Units_XP2 (UnitType, ResourceCost)
SELECT UnitType, 40 FROM Units WHERE UnitType = 'UNIT_DLV_SELF_PROPELLED_ARTILLERY';

UPDATE Units_XP2 SET ResourceCost = 40
WHERE UnitType = 'UNIT_DLV_SELF_PROPELLED_ARTILLERY';

-- Reduce self-propelled artillery ranged strength from 95 to 90.
UPDATE Units SET RangedCombat = 90
WHERE UnitType = 'UNIT_DLV_SELF_PROPELLED_ARTILLERY';
