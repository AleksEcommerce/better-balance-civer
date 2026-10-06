-- Убираем бесплатные копии морских юнитов от Арсенала.
DELETE FROM BuildingModifiers
WHERE BuildingType = 'BUILDING_VENETIAN_ARSENAL'
AND ModifierId IN (
    SELECT ModifierId FROM Modifiers
    WHERE ModifierType = 'MODIFIER_PLAYER_CITIES_ADJUST_EXTRA_UNIT_COPY_TAG'
);

-- +6 производства от самого чуда, независимо от состояния верфи.
INSERT OR REPLACE INTO Building_YieldChanges (BuildingType, YieldType, YieldChange)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'YIELD_PRODUCTION', 6);

-- Верфь даёт +100% производства морских юнитов только в городе с Арсеналом.
-- Модификатор здания отключается движком при разграблении верфи.
INSERT INTO Requirements (RequirementId, RequirementType)
VALUES ('BBC_CITY_HAS_VENETIAN_ARSENAL', 'REQUIREMENT_CITY_HAS_BUILDING');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('BBC_CITY_HAS_VENETIAN_ARSENAL', 'BuildingType', 'BUILDING_VENETIAN_ARSENAL');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('BBC_ARSENAL_CITY_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('BBC_ARSENAL_CITY_REQUIREMENTS', 'BBC_CITY_HAS_VENETIAN_ARSENAL');
INSERT INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId)
VALUES ('BBC_ARSENAL_NAVAL_PRODUCTION', 'MODIFIER_CITY_ADJUST_UNIT_DOMAIN_PRODUCTION', 'BBC_ARSENAL_CITY_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('BBC_ARSENAL_NAVAL_PRODUCTION', 'Domain', 'DOMAIN_SEA'),
('BBC_ARSENAL_NAVAL_PRODUCTION', 'Amount', '100');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_SHIPYARD', 'BBC_ARSENAL_NAVAL_PRODUCTION');
-- Стандартные +2 очка великого инженера не изменяются.
