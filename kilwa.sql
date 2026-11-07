-- Kilwa city: 15% with one suzerain, 30% with two; other cities: 7% with two.
CREATE TEMP TABLE BBC_KilwaEmpire (ModifierId TEXT, OriginalRequirements TEXT);
INSERT INTO BBC_KilwaEmpire VALUES
('KILWA_PLAYERCITIES_ADDSCIENCEYIELD', 'SCIENTIFIC_SUZERAIN_2_REQUIREMENTS'),
('KILWA_PLAYERCITIES_ADDFAITHYIELD', 'RELIGIOUS_SUZERAIN_2_REQUIREMENTS'),
('KILWA_PLAYERCITIES_ADDGOLDYIELD', 'TRADE_SUZERAIN_2_REQUIREMENTS'),
('KILWA_PLAYERCITIES_ADDCULTUREYIELD', 'CULTURAL_SUZERAIN_2_REQUIREMENTS'),
('KILWA_PLAYERCITIES_ADDPRODUCTIONUNITS', 'MILITARISTIC_SUZERAIN_2_REQUIREMENTS'),
('KILWA_PLAYERCITIES_ADDPRODUCTIONBUILDINGS', 'INDUSTRIAL_SUZERAIN_2_REQUIREMENTS'),
('KILWA_PLAYERCITIES_ADDPRODUCTIONDISTRICTS', 'INDUSTRIAL_SUZERAIN_2_REQUIREMENTS');

UPDATE ModifierArguments SET Value = 7
WHERE Name = 'Amount' AND ModifierId IN (SELECT ModifierId FROM BBC_KilwaEmpire);

INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType, Inverse)
VALUES ('BBC_KILWA_CITY_WITHOUT_WONDER', 'REQUIREMENT_CITY_HAS_BUILDING', 1);
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('BBC_KILWA_CITY_WITHOUT_WONDER', 'BuildingType', 'BUILDING_KILWA_KISIWANI');

-- Nest the original set to preserve its ANY/ALL logic and city-state conditions.
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
SELECT 'BBC_' || ModifierId || '_SUZERAIN', 'REQUIREMENT_REQUIREMENTSET_IS_MET'
FROM BBC_KilwaEmpire;
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
SELECT 'BBC_' || ModifierId || '_SUZERAIN', 'RequirementSetId', OriginalRequirements
FROM BBC_KilwaEmpire;
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
SELECT 'BBC_' || ModifierId || '_OTHER_CITIES', 'REQUIREMENTSET_TEST_ALL'
FROM BBC_KilwaEmpire;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
SELECT 'BBC_' || ModifierId || '_OTHER_CITIES', 'BBC_' || ModifierId || '_SUZERAIN'
FROM BBC_KilwaEmpire;
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
SELECT 'BBC_' || ModifierId || '_OTHER_CITIES', 'BBC_KILWA_CITY_WITHOUT_WONDER'
FROM BBC_KilwaEmpire;
UPDATE Modifiers SET SubjectRequirementSetId = 'BBC_' || ModifierId || '_OTHER_CITIES'
WHERE ModifierId IN (SELECT ModifierId FROM BBC_KilwaEmpire);
-- A separate single-city bonus supplies the second 15% to Kilwa's own city.
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
SELECT 'BBC_KILWA_LOCAL_' || e.ModifierId, m.ModifierType, e.OriginalRequirements
FROM BBC_KilwaEmpire e JOIN Modifiers m
ON m.ModifierId = REPLACE(e.ModifierId, 'KILWA_PLAYERCITIES_', 'KILWA_SINGLE_');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value)
SELECT 'BBC_KILWA_LOCAL_' || e.ModifierId, a.Name,
       CASE WHEN a.Name = 'Amount' THEN '15' ELSE a.Value END
FROM BBC_KilwaEmpire e JOIN ModifierArguments a ON a.ModifierId = e.ModifierId;
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
SELECT 'BUILDING_KILWA_KISIWANI', 'BBC_KILWA_LOCAL_' || ModifierId
FROM BBC_KilwaEmpire;

DROP TABLE BBC_KilwaEmpire;
