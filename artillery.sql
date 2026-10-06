-- Артиллерия: дальность обстрела 3 клетки вместо 2.
UPDATE Units
SET Range = 3
WHERE UnitType = 'UNIT_ARTILLERY';
