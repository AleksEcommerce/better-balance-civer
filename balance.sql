-- =====================================
-- ДВИЖЕНИЕ
-- =====================================

-- +1 всем наземным юнитам
UPDATE Units
SET BaseMoves = BaseMoves + 1
WHERE Domain = 'DOMAIN_LAND';

-- +2 всем морским юнитам
UPDATE Units
SET BaseMoves = BaseMoves + 2
WHERE Domain = 'DOMAIN_SEA';

-- +1 юнитам, которые могут плыть (embark)
UPDATE Units
SET BaseMoves = BaseMoves + 1
WHERE Domain = 'DOMAIN_LAND'
AND CanEmbark = 1;

-- =====================================
-- РЕЛИГИОЗНЫЕ ЮНИТЫ
-- =====================================

-- +1 заряд миссионерам
UPDATE Units
SET SpreadCharges = SpreadCharges + 1
WHERE UnitType = 'UNIT_MISSIONARY';

-- +1 заряд инквизиторам
UPDATE Units
SET SpreadCharges = SpreadCharges + 1
WHERE UnitType = 'UNIT_INQUISITOR';

-- =====================================
-- АВИАЦИЯ
-- =====================================

-- +1 к радиусу атаки всем воздушным юнитам
UPDATE Units
SET Range = Range + 1
WHERE Domain = 'DOMAIN_AIR';

-- =====================================
-- ТОРГОВЛЯ
-- =====================================

-- +1 золото и +1 еда всем торговым путям
UPDATE Routes
SET YieldChangeGold = YieldChangeGold + 1,
    YieldChangeFood = YieldChangeFood + 1;


-- =====================================
-- ИНЖЕНЕРЫ
-- =====================================

-- +1 заряд военному инженеру
UPDATE Units
SET BuildCharges = BuildCharges + 1
WHERE UnitType = 'UNIT_MILITARY_ENGINEER';


-- =====================================
-- АПГРЕЙДЫ
-- =====================================

-- -25% к стоимости апгрейда для всех
UPDATE GlobalParameters
SET Value = Value * 0.75
WHERE Name = 'UNIT_UPGRADE_COST_PER_PRODUCTION';


-- =====================================
-- AI И МОРЕ
-- =====================================

-- AI больше ценит морские юниты
UPDATE AiFavoredItems
SET Value = Value + 2
WHERE ItemType IN (
  'UNIT_QUADRIREME',
  'UNIT_CARAVEL',
  'UNIT_FRIGATE',
  'UNIT_IRONCLAD',
  'UNIT_DESTROYER',
  'UNIT_SUBMARINE'
);

-- AI больше ценит морские технологии
UPDATE AiFavoredItems
SET Value = Value + 2
WHERE ItemType IN (
  'TECH_SAILING',
  'TECH_SHIPBUILDING',
  'TECH_CARTOGRAPHY'
);

-- AI больше ценит морские атаки
UPDATE AiFavoredItems
SET Value = Value + 2
WHERE ItemType = 'OPERATION_NAVAL_ATTACK';