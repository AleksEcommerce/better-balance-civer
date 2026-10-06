-- Обычные подлодки нельзя улучшать до атомных
DELETE FROM UnitUpgrades
WHERE Unit = 'UNIT_SUBMARINE'
AND UpgradeUnit = 'UNIT_NUCLEAR_SUBMARINE';
