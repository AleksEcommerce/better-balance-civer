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
