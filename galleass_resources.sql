-- Steel and Thunder: Unit Expansion: replace the galleass build resource with 5 iron.
UPDATE Units SET StrategicResource = 'RESOURCE_IRON'
WHERE UnitType = 'UNIT_DLV_GALLEASS';

INSERT OR IGNORE INTO Units_XP2 (UnitType, ResourceCost)
SELECT UnitType, 5 FROM Units WHERE UnitType = 'UNIT_DLV_GALLEASS';

UPDATE Units_XP2 SET ResourceCost = 5
WHERE UnitType = 'UNIT_DLV_GALLEASS';
