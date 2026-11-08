-- Run after the general +1 air range adjustment.
-- Include the standard Jet Fighter and unique replacements, preserving longer ranges.
WITH RECURSIVE JetFighters(UnitType) AS (
    SELECT UnitType FROM Units WHERE UnitType = 'UNIT_JET_FIGHTER'
    UNION
    SELECT r.CivUniqueUnitType FROM UnitReplaces r
    JOIN JetFighters j ON r.ReplacesUnitType = j.UnitType
)
UPDATE Units SET Range = 8
WHERE UnitType IN (SELECT UnitType FROM JetFighters) AND Range < 8;

UPDATE Units SET Cost = 700 WHERE UnitType = 'UNIT_SUKHOI_SU35';
UPDATE Units SET Cost = 720 WHERE UnitType = 'UNIT_CHENGDU_J20';

-- Reduce only fighter stealth; bomber stealth retains its original values.
UPDATE ModifierArguments SET Value = 5
WHERE Name = 'Amount' AND ModifierId IN (
    'STEALTH_FIGHTER_BONUS_VS_FIGHTERS',
    'STEALTH_FIGHTER_BONUS_VS_ANTIAIR'
);
