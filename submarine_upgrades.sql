-- Обычные подлодки нельзя улучшать до атомных
DELETE FROM UnitUpgrades
WHERE Unit = 'UNIT_SUBMARINE'
AND UpgradeUnit = 'UNIT_NUCLEAR_SUBMARINE';

-- Атомная подлодка требует столько же железа, сколько обычная
UPDATE Units
SET StrategicResource = 'RESOURCE_IRON'
WHERE UnitType = 'UNIT_NUCLEAR_SUBMARINE';

UPDATE Units_XP2
SET ResourceCost = (
    SELECT ResourceCost FROM Units_XP2
    WHERE UnitType = 'UNIT_SUBMARINE'
)
WHERE UnitType = 'UNIT_NUCLEAR_SUBMARINE';

-- Атомная подлодка расходует 1 уран за ход на содержание
UPDATE Units_XP2
SET ResourceMaintenanceType = 'RESOURCE_URANIUM',
    ResourceMaintenanceAmount = 1
WHERE UnitType = 'UNIT_NUCLEAR_SUBMARINE';

-- Обслуживание атомной подлодки: 12 золота за ход
UPDATE Units
SET Maintenance = 12
WHERE UnitType = 'UNIT_NUCLEAR_SUBMARINE';
