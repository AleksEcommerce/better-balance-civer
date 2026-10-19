-- Earth 2020 Civs: balance against the standard Modern Armor (95 strength, 680 production).
-- Preserve movement, abilities, gold upkeep and resource compatibility rules.
UPDATE Units SET Combat = 93, Cost = 640 WHERE UnitType = 'UNIT_T90';
UPDATE Units SET Combat = 90, Cost = 600 WHERE UnitType = 'UNIT_TAM';
UPDATE Units SET Combat = 95, Cost = 700
WHERE UnitType IN ('UNIT_TYPE99', 'UNIT_KARRAR');
UPDATE Units SET Combat = 95, Cost = 720
WHERE UnitType IN ('UNIT_TYPE90_JAPAN', 'UNIT_LECLERC', 'UNIT_MERKAVA');
