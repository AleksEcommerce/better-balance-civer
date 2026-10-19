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

-- Unique missile cruiser replacements (including Earth 2020 Civs): at least 4 range.
UPDATE Units SET Range = 4
WHERE UnitType IN (SELECT CivUniqueUnitType FROM UnitReplaces
                   WHERE ReplacesUnitType = 'UNIT_MISSILE_CRUISER')
  AND Range < 4;

-- Steel and Thunder: Unit Expansion self-propelled artillery: +1 movement.
-- Base 3, global land +1, siege -1, this exception +1 => 4 total.
UPDATE Units SET BaseMoves = BaseMoves + 1
WHERE UnitType = 'UNIT_DLV_SELF_PROPELLED_ARTILLERY';
