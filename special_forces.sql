-- Спецназ открывается технологией Радио
UPDATE Units
SET PrereqTech = 'TECH_RADIO'
WHERE UnitType = 'UNIT_SPEC_OPS';

-- Дальность десантирования: обычная 10 клеток, увеличенная 12 клеток.
UPDATE GlobalParameters
SET Value = 10
WHERE Name = 'PARADROP_SHORT_RANGE';

UPDATE GlobalParameters
SET Value = 12
WHERE Name = 'PARADROP_LONG_RANGE';

-- Base stats; generic combat-strength modifiers apply to melee and ranged combat.
UPDATE Units SET Combat = 70, RangedCombat = 65, Cost = 500
WHERE UnitType = 'UNIT_SPEC_OPS';

INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('BBC_REQUIRE_SPEC_OPS', 'REQUIREMENT_UNIT_TYPE_MATCHES');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('BBC_REQUIRE_SPEC_OPS', 'UnitType', 'UNIT_SPEC_OPS');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('BBC_SPEC_OPS_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('BBC_SPEC_OPS_REQUIREMENTS', 'BBC_REQUIRE_SPEC_OPS');
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
('BBC_SPEC_OPS_SATELLITES_STRENGTH', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 'BBC_SPEC_OPS_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('BBC_SPEC_OPS_SATELLITES_STRENGTH', 'Amount', 5);
INSERT INTO TechnologyModifiers (TechnologyType, ModifierId) VALUES
('TECH_SATELLITES', 'BBC_SPEC_OPS_SATELLITES_STRENGTH');
INSERT INTO ModifierStrings (ModifierId, Context, Text) VALUES
('BBC_SPEC_OPS_SATELLITES_STRENGTH', 'Preview', 'LOC_BBC_SPEC_OPS_SATELLITES_PREVIEW');

UPDATE Technologies SET Description = 'LOC_BBC_SATELLITES_DESCRIPTION'
WHERE TechnologyType = 'TECH_SATELLITES' AND (Description IS NULL OR Description = '');
