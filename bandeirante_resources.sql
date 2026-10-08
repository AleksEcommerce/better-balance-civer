-- Brazilian Bandeirante: 3 niter to build.
UPDATE Units SET StrategicResource = 'RESOURCE_NITER'
WHERE UnitType = 'UNIT_BRAZILIAN_BANDEIRANTE';

INSERT OR IGNORE INTO Units_XP2 (UnitType, ResourceCost)
SELECT UnitType, 3 FROM Units WHERE UnitType = 'UNIT_BRAZILIAN_BANDEIRANTE';

UPDATE Units_XP2 SET ResourceCost = 3
WHERE UnitType = 'UNIT_BRAZILIAN_BANDEIRANTE';
