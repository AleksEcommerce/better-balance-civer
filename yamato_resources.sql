-- Yamato inherits the battleship's strategic resource rules after rebalances.
UPDATE Units
SET StrategicResource = (SELECT StrategicResource FROM Units WHERE UnitType = 'UNIT_BATTLESHIP')
WHERE UnitType = 'UNIT_JAPANESE_YAMATO'
  AND EXISTS (SELECT 1 FROM Units WHERE UnitType = 'UNIT_BATTLESHIP');

INSERT OR IGNORE INTO Units_XP2 (UnitType)
SELECT UnitType FROM Units WHERE UnitType = 'UNIT_JAPANESE_YAMATO';

UPDATE Units_XP2
SET ResourceCost = (SELECT ResourceCost FROM Units_XP2 WHERE UnitType = 'UNIT_BATTLESHIP'),
    ResourceMaintenanceType = (SELECT ResourceMaintenanceType FROM Units_XP2 WHERE UnitType = 'UNIT_BATTLESHIP'),
    ResourceMaintenanceAmount = (SELECT ResourceMaintenanceAmount FROM Units_XP2 WHERE UnitType = 'UNIT_BATTLESHIP')
WHERE UnitType = 'UNIT_JAPANESE_YAMATO'
  AND EXISTS (SELECT 1 FROM Units_XP2 WHERE UnitType = 'UNIT_BATTLESHIP');
