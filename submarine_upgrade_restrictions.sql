-- Conventional submarines, including Germany's U-Boat, cannot upgrade
-- to nuclear submarines or their unique replacements (including Earth 2020).
DELETE FROM UnitUpgrades
WHERE (Unit = 'UNIT_SUBMARINE'
       OR Unit IN (SELECT CivUniqueUnitType FROM UnitReplaces
                   WHERE ReplacesUnitType = 'UNIT_SUBMARINE'))
  AND (UpgradeUnit = 'UNIT_NUCLEAR_SUBMARINE'
       OR UpgradeUnit IN (SELECT CivUniqueUnitType FROM UnitReplaces
                          WHERE ReplacesUnitType = 'UNIT_NUCLEAR_SUBMARINE'));

-- Equal gold upkeep for standard and unique nuclear submarines.
UPDATE Units SET Maintenance = 12
WHERE UnitType = 'UNIT_NUCLEAR_SUBMARINE'
   OR UnitType IN (SELECT CivUniqueUnitType FROM UnitReplaces
                   WHERE ReplacesUnitType = 'UNIT_NUCLEAR_SUBMARINE');
