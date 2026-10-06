-- ДВИЖЕНИЕ
-- +1 всем наземным и +2 всем морским юнитам.
UPDATE Units SET BaseMoves = BaseMoves + 1 WHERE Domain = 'DOMAIN_LAND';
UPDATE Units SET BaseMoves = BaseMoves + 2 WHERE Domain = 'DOMAIN_SEA';

-- +1 к движению наземных юнитов на воде для основных цивилизаций.
INSERT INTO Modifiers (ModifierId, ModifierType)
VALUES ('BBC_EMBARKED_MOVEMENT', 'MODIFIER_PLAYER_ADJUST_EMBARKED_MOVEMENT');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('BBC_EMBARKED_MOVEMENT', 'Amount', '1');
INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES ('TRAIT_LEADER_MAJOR_CIV', 'BBC_EMBARKED_MOVEMENT');

-- РЕЛИГИОЗНЫЕ ЮНИТЫ
UPDATE Units SET SpreadCharges = SpreadCharges + 1
WHERE UnitType IN ('UNIT_MISSIONARY', 'UNIT_INQUISITOR');

-- АВИАЦИЯ
UPDATE Units SET Range = Range + 1 WHERE Domain = 'DOMAIN_AIR';

-- ИНЖЕНЕРЫ
UPDATE Units SET BuildCharges = BuildCharges + 1
WHERE UnitType = 'UNIT_MILITARY_ENGINEER';

-- УЛУЧШЕНИЯ: -25% к базовой цене, производственной части и минимальной цене.
UPDATE GlobalParameters SET Value = CAST(Value AS REAL) * 0.75
WHERE Name IN ('UPGRADE_BASE_COST', 'UPGRADE_NET_PRODUCTION_PERCENT_COST', 'UPGRADE_MINIMUM_COST');

-- ИИ: повышенная оценка морских боевых юнитов.
UPDATE AiFavoredItems SET Value = Value + 2
WHERE Item = 'PSEUDOYIELD_UNIT_NAVAL_COMBAT';

-- ИИ: предпочтение существующих морских технологий.
UPDATE AiFavoredItems SET Favored = 1
WHERE Item IN ('TECH_SAILING', 'TECH_SHIPBUILDING', 'TECH_CARTOGRAPHY');
