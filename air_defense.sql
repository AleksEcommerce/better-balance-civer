-- ПВО не расходует нефть на содержание
UPDATE Units_XP2
SET ResourceMaintenanceAmount = 0,
    ResourceMaintenanceType = NULL
WHERE UnitType IN ('UNIT_ANTIAIR_GUN', 'UNIT_MOBILE_SAM')
AND ResourceMaintenanceType = 'RESOURCE_OIL';

-- Стоимость зенитной пушки: 380 производства
UPDATE Units
SET Cost = 380
WHERE UnitType = 'UNIT_ANTIAIR_GUN';

-- Base anti-air strength. Preserve the global +5 AA support rule.
UPDATE Units SET AntiAirCombat = 100 WHERE UnitType = 'UNIT_ANTIAIR_GUN';
UPDATE Units SET Cost = 590, AntiAirCombat = 110 WHERE UnitType = 'UNIT_MOBILE_SAM';

-- Each Mobile SAM grants +5 additional AA strength to adjacent owned Mobile SAMs.
INSERT INTO Types (Type, Kind) VALUES
('BBC_ABILITY_SAM_SUPPORT', 'KIND_ABILITY'),
('BBC_MODIFIER_SAM_AA_AURA', 'KIND_MODIFIER');
INSERT INTO Tags (Tag, Vocabulary) VALUES ('BBC_CLASS_MOBILE_SAM', 'ABILITY_CLASS');
INSERT INTO TypeTags (Type, Tag) VALUES
('UNIT_MOBILE_SAM', 'BBC_CLASS_MOBILE_SAM'),
('BBC_ABILITY_SAM_SUPPORT', 'BBC_CLASS_MOBILE_SAM');
INSERT INTO UnitAbilities (UnitAbilityType, Name, Description) VALUES
('BBC_ABILITY_SAM_SUPPORT', 'LOC_BBC_SAM_SUPPORT_NAME', 'LOC_BBC_SAM_SUPPORT_DESCRIPTION');
INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES
('BBC_MODIFIER_SAM_AA_AURA', 'COLLECTION_PLAYER_UNITS', 'EFFECT_ADJUST_UNIT_ANTI_AIR_STRENGTH');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('BBC_SAM_ADJACENT_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('BBC_SAM_ADJACENT_OWNER', 'REQUIREMENT_PLOT_ADJACENT_TO_OWNER'),
('BBC_SAM_TYPE', 'REQUIREMENT_UNIT_TYPE_MATCHES');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('BBC_SAM_ADJACENT_OWNER', 'MinDistance', 1),
('BBC_SAM_ADJACENT_OWNER', 'MaxDistance', 1),
('BBC_SAM_TYPE', 'UnitType', 'UNIT_MOBILE_SAM');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('BBC_SAM_ADJACENT_REQUIREMENTS', 'BBC_SAM_ADJACENT_OWNER'),
('BBC_SAM_ADJACENT_REQUIREMENTS', 'BBC_SAM_TYPE');
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
('BBC_SAM_SUPPORT_AURA', 'BBC_MODIFIER_SAM_AA_AURA', 'BBC_SAM_ADJACENT_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('BBC_SAM_SUPPORT_AURA', 'Amount', 5);
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
('BBC_ABILITY_SAM_SUPPORT', 'BBC_SAM_SUPPORT_AURA');
