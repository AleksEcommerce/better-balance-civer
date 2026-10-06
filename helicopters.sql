-- Flying Units Expansion: ударный вертолёт расходует нефть вместо алюминия.
UPDATE Units_XP2
SET ResourceMaintenanceType = 'RESOURCE_OIL'
WHERE UnitType = 'UNIT_ADV_HELI';

-- Транспортный вертолёт: 6 очков движения и 1 нефть за ход.
UPDATE Units
SET BaseMoves = 6
WHERE UnitType = 'UNIT_AIRB_HELI';

INSERT INTO Units_XP2 (UnitType, ResourceMaintenanceType, ResourceMaintenanceAmount)
SELECT UnitType, 'RESOURCE_OIL', 1 FROM Units
WHERE UnitType = 'UNIT_AIRB_HELI'
AND NOT EXISTS (SELECT 1 FROM Units_XP2 WHERE UnitType = 'UNIT_AIRB_HELI');

UPDATE Units_XP2
SET ResourceMaintenanceType = 'RESOURCE_OIL',
    ResourceMaintenanceAmount = 1
WHERE UnitType = 'UNIT_AIRB_HELI';

-- Ударный вертолёт: дальность 2 и сила обстрела 70.
UPDATE Units SET Range = 2, RangedCombat = 70
WHERE UnitType = 'UNIT_ADV_HELI';

-- Отдельный класс ограничивает бонус только ударным вертолётом.
INSERT INTO Tags (Tag, Vocabulary) VALUES ('BBC_CLASS_ATTACK_HELI', 'ABILITY_CLASS');
INSERT INTO Types (Type, Kind) VALUES ('BBC_ABILITY_HELI_ANTI_CAVALRY', 'KIND_ABILITY');
INSERT INTO TypeTags (Type, Tag)
SELECT UnitType, 'BBC_CLASS_ATTACK_HELI' FROM Units WHERE UnitType = 'UNIT_ADV_HELI';
INSERT INTO TypeTags (Type, Tag) VALUES ('BBC_ABILITY_HELI_ANTI_CAVALRY', 'BBC_CLASS_ATTACK_HELI');
INSERT INTO UnitAbilities (UnitAbilityType, Name, Description)
VALUES ('BBC_ABILITY_HELI_ANTI_CAVALRY', 'LOC_BBC_HELI_ANTI_CAVALRY_NAME', 'LOC_BBC_HELI_ANTI_CAVALRY_DESCRIPTION');

INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('BBC_HELI_OPPONENT_LIGHT_CAVALRY', 'REQUIREMENT_OPPONENT_UNIT_PROMOTION_CLASS_MATCHES'),
('BBC_HELI_OPPONENT_HEAVY_CAVALRY', 'REQUIREMENT_OPPONENT_UNIT_PROMOTION_CLASS_MATCHES');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('BBC_HELI_OPPONENT_LIGHT_CAVALRY', 'UnitPromotionClass', 'PROMOTION_CLASS_LIGHT_CAVALRY'),
('BBC_HELI_OPPONENT_HEAVY_CAVALRY', 'UnitPromotionClass', 'PROMOTION_CLASS_HEAVY_CAVALRY');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('BBC_HELI_OPPONENT_CAVALRY', 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('BBC_HELI_OPPONENT_CAVALRY', 'BBC_HELI_OPPONENT_LIGHT_CAVALRY'),
('BBC_HELI_OPPONENT_CAVALRY', 'BBC_HELI_OPPONENT_HEAVY_CAVALRY');
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
VALUES ('BBC_HELI_ANTI_CAVALRY', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'BBC_HELI_OPPONENT_CAVALRY');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('BBC_HELI_ANTI_CAVALRY', 'Amount', '15');
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId)
VALUES ('BBC_ABILITY_HELI_ANTI_CAVALRY', 'BBC_HELI_ANTI_CAVALRY');
INSERT INTO ModifierStrings (ModifierId, Context, Text)
VALUES ('BBC_HELI_ANTI_CAVALRY', 'Preview', 'LOC_BBC_HELI_ANTI_CAVALRY_PREVIEW');
