-- Preserve a minimum base capacity of 4 aircraft without EpsTweak.
-- Promotion and fleet/armada capacity bonuses remain separate.
UPDATE Units SET AirSlots = 4
WHERE (UnitType = 'UNIT_AIRCRAFT_CARRIER'
       OR UnitType IN (SELECT CivUniqueUnitType FROM UnitReplaces
                       WHERE ReplacesUnitType = 'UNIT_AIRCRAFT_CARRIER'))
  AND COALESCE(AirSlots, 0) < 4;

-- Earth 2020 Civs: inherit standard carrier base AA after Aircraft Carriers Perfected.
UPDATE Units
SET AntiAirCombat = (SELECT AntiAirCombat FROM Units WHERE UnitType = 'UNIT_AIRCRAFT_CARRIER')
WHERE UnitType IN ('UNIT_FORD_CARRIER', 'UNIT_SHANDONG_CARRIER',
                   'UNIT_KUZNETSOV_CARRIER', 'UNIT_ELIZABETH_CARRIER', 'UNIT_DEGAULLE_CARRIER')
  AND EXISTS (SELECT 1 FROM Units WHERE UnitType = 'UNIT_AIRCRAFT_CARRIER');

-- Explicit base-capacity exceptions run after the general minimum of four.
UPDATE Units SET AirSlots = 5 WHERE UnitType = 'UNIT_FORD_CARRIER';
UPDATE Units SET AirSlots = 3 WHERE UnitType = 'UNIT_KUZNETSOV_CARRIER';

-- Base anti-air strength for the standard carrier and all unique replacements.
UPDATE Units SET AntiAirCombat = 80
WHERE UnitType = 'UNIT_AIRCRAFT_CARRIER'
   OR UnitType IN (SELECT CivUniqueUnitType FROM UnitReplaces
                   WHERE ReplacesUnitType = 'UNIT_AIRCRAFT_CARRIER');

-- Equal base sight for standard and unique aircraft carriers.
UPDATE Units SET BaseSightRange = 3
WHERE UnitType = 'UNIT_AIRCRAFT_CARRIER'
   OR UnitType IN (SELECT CivUniqueUnitType FROM UnitReplaces
                   WHERE ReplacesUnitType = 'UNIT_AIRCRAFT_CARRIER');
