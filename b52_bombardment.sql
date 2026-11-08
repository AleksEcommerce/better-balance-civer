-- B-52: bombardment strength and final attack range (after the general air bonus).
UPDATE Units SET Bombard = 130, Range = 19 WHERE UnitType = 'UNIT_B52_STRATOFORTRESS';

-- B-2 Spirit: final attack range. Other characteristics are preserved.
UPDATE Units SET Range = 17 WHERE UnitType = 'UNIT_B2_SPIRIT';
