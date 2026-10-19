-- Earth 2020 Civs: balance unique helicopters against the standard 86 strength / 540 production.
-- Preserve movement, abilities, gold upkeep and resource compatibility rules.
UPDATE Units SET Combat = 86, Cost = 600 WHERE UnitType = 'UNIT_MIL_MI_24';
UPDATE Units SET Combat = 90, Cost = 630 WHERE UnitType = 'UNIT_AH_64_APACHE';
UPDATE Units SET Combat = 86, Cost = 600 WHERE UnitType = 'UNIT_Z_10';
UPDATE Units SET Combat = 88, Cost = 630 WHERE UnitType = 'UNIT_TIGER';
UPDATE Units SET Combat = 86, Cost = 600 WHERE UnitType = 'UNIT_ROOIVALK';
UPDATE Units SET Combat = 86, Cost = 570 WHERE UnitType = 'UNIT_A129_MANGUSTA';
