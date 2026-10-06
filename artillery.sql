-- Артиллерия: дальность обстрела 3 клетки вместо 2.
UPDATE Units
SET Range = 3
WHERE UnitType = 'UNIT_ARTILLERY';

-- Ракетный крейсер: дальность обстрела 4 клетки.
UPDATE Units
SET Range = 4
WHERE UnitType = 'UNIT_MISSILE_CRUISER';

-- Все осадные юниты: -1 к движению после общего +1 наземным.
UPDATE Units
SET BaseMoves = BaseMoves - 1
WHERE PromotionClass = 'PROMOTION_CLASS_SIEGE';
