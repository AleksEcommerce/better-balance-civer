-- Remove oil upkeep from the Biplane; preserve build resources and gold upkeep.
UPDATE Units_XP2
SET ResourceMaintenanceType = NULL, ResourceMaintenanceAmount = 0
WHERE UnitType = 'UNIT_BIPLANE' AND ResourceMaintenanceType = 'RESOURCE_OIL';

-- Balance the resource-free upkeep: weaker first-generation aircraft.
UPDATE Units SET Combat = 70, RangedCombat = 65
WHERE UnitType = 'UNIT_BIPLANE';
