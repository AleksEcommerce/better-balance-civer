-- Australian SASR: 10 niter to build; existing upkeep is preserved.
UPDATE Units SET StrategicResource = 'RESOURCE_NITER'
WHERE UnitType = 'UNIT_AUSTRALIAN_SASR';

INSERT OR IGNORE INTO Units_XP2 (UnitType, ResourceCost)
SELECT UnitType, 10 FROM Units WHERE UnitType = 'UNIT_AUSTRALIAN_SASR';

UPDATE Units_XP2 SET ResourceCost = 10
WHERE UnitType = 'UNIT_AUSTRALIAN_SASR';
