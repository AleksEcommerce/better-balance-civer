-- Macron: increase only the flat power plant production bonus to +10.
UPDATE ModifierArguments SET Value = 10
WHERE Name = 'Amount' AND ModifierId IN (
    'TRAIT_MACRON_COAL_POWER_PLANT_PRODUCTION_MODIFIER',
    'TRAIT_MACRON_FOSSIL_FUEL_POWER_PLANT_PRODUCTION_MODIFIER',
    'TRAIT_MACRON_POWER_PLANT_PRODUCTION_MODIFIER'
);

-- Macron also receives +2 gold from Banks.
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType)
VALUES ('BBC_MACRON_BANK_GOLD', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('BBC_MACRON_BANK_GOLD', 'BuildingType', 'BUILDING_BANK'),
       ('BBC_MACRON_BANK_GOLD', 'YieldType', 'YIELD_GOLD'),
       ('BBC_MACRON_BANK_GOLD', 'Amount', 2);
INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId)
SELECT TraitType, 'BBC_MACRON_BANK_GOLD' FROM Traits
WHERE TraitType='TRAIT_LEADER_MACRON';

-- Optional natural gas power plant from the installed resource mod.
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType)
SELECT 'BBC_MACRON_GAS_POWER_PLANT_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE'
WHERE EXISTS (SELECT 1 FROM Buildings WHERE BuildingType='BUILDING_NATURAL_GAS_POWER_PLANT');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value)
SELECT 'BBC_MACRON_GAS_POWER_PLANT_PRODUCTION', 'BuildingType', BuildingType
FROM Buildings WHERE BuildingType='BUILDING_NATURAL_GAS_POWER_PLANT';
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value)
SELECT ModifierId, 'YieldType', 'YIELD_PRODUCTION' FROM Modifiers
WHERE ModifierId='BBC_MACRON_GAS_POWER_PLANT_PRODUCTION';
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value)
SELECT ModifierId, 'Amount', 10 FROM Modifiers
WHERE ModifierId='BBC_MACRON_GAS_POWER_PLANT_PRODUCTION';
INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId)
SELECT t.TraitType, m.ModifierId FROM Traits t CROSS JOIN Modifiers m
WHERE t.TraitType='TRAIT_LEADER_MACRON' AND m.ModifierId='BBC_MACRON_GAS_POWER_PLANT_PRODUCTION';
