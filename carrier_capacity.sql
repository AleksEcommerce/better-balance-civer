-- Preserve a minimum base capacity of 4 aircraft without EpsTweak.
-- Promotion and fleet/armada capacity bonuses remain separate.
UPDATE Units SET AirSlots = 4
WHERE (UnitType = 'UNIT_AIRCRAFT_CARRIER'
       OR UnitType IN (SELECT CivUniqueUnitType FROM UnitReplaces
                       WHERE ReplacesUnitType = 'UNIT_AIRCRAFT_CARRIER'))
  AND COALESCE(AirSlots, 0) < 4;
