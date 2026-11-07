-- Expand existing regional building effects, including wonders and modded buildings.
-- CASE evaluates the original range once. Reapplying this file does not increase it again.
UPDATE Buildings
SET RegionalRange = CASE RegionalRange WHEN 6 THEN 8 WHEN 9 THEN 11 END
WHERE RegionalRange IN (6, 9);
-- Magnus Vertical Integration consumes the incoming regional effects and needs no range override.
