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

-- Ford-class carrier combat strength.
UPDATE Units SET Combat = 75 WHERE UnitType = 'UNIT_FORD_CARRIER';

-- Guidance Systems improves all existing and future standard/unique carriers.
INSERT INTO Types (Type, Kind) VALUES ('BBC_CARRIER_GUIDANCE_AA', 'KIND_MODIFIER');
INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES
('BBC_CARRIER_GUIDANCE_AA', 'COLLECTION_PLAYER_UNITS', 'EFFECT_ADJUST_UNIT_ANTI_AIR_STRENGTH');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('BBC_CARRIER_GUIDANCE_REQUIREMENTS', 'REQUIREMENTSET_TEST_ANY');
INSERT INTO Requirements (RequirementId, RequirementType)
SELECT 'BBC_CARRIER_GUIDANCE_' || UnitType, 'REQUIREMENT_UNIT_TYPE_MATCHES'
FROM Units WHERE UnitType = 'UNIT_AIRCRAFT_CARRIER'
OR UnitType IN (SELECT CivUniqueUnitType FROM UnitReplaces WHERE ReplacesUnitType = 'UNIT_AIRCRAFT_CARRIER');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
SELECT RequirementId, 'UnitType', SUBSTR(RequirementId, LENGTH('BBC_CARRIER_GUIDANCE_') + 1)
FROM Requirements WHERE RequirementId GLOB 'BBC_CARRIER_GUIDANCE_UNIT_*';
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
SELECT 'BBC_CARRIER_GUIDANCE_REQUIREMENTS', RequirementId
FROM Requirements WHERE RequirementId GLOB 'BBC_CARRIER_GUIDANCE_UNIT_*';
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
('BBC_CARRIER_GUIDANCE_BONUS', 'BBC_CARRIER_GUIDANCE_AA', 'BBC_CARRIER_GUIDANCE_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('BBC_CARRIER_GUIDANCE_BONUS', 'Amount', 10);
INSERT INTO TechnologyModifiers (TechnologyType, ModifierId) VALUES
('TECH_GUIDANCE_SYSTEMS', 'BBC_CARRIER_GUIDANCE_BONUS');
