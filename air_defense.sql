-- ПВО не расходует нефть на содержание
UPDATE Units_XP2
SET ResourceMaintenanceAmount = 0,
    ResourceMaintenanceType = NULL
WHERE UnitType IN ('UNIT_ANTIAIR_GUN', 'UNIT_MOBILE_SAM')
AND ResourceMaintenanceType = 'RESOURCE_OIL';
