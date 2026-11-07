-- Мавзолей в Галикарнасе не даёт великим инженерам дополнительный заряд.
DELETE FROM BuildingModifiers
WHERE BuildingType = 'BUILDING_HALICARNASSUS_MAUSOLEUM'
AND ModifierId = 'HALICARNASSUS_ADJUST_ENGINEER_CHARGES';

-- Permanent city culture and Great Engineer points.
INSERT OR REPLACE INTO Building_GreatPersonPoints (BuildingType, GreatPersonClassType, PointsPerTurn)
VALUES ('BUILDING_HALICARNASSUS_MAUSOLEUM', 'GREAT_PERSON_CLASS_ENGINEER', 2);
INSERT OR REPLACE INTO Building_YieldChanges (BuildingType, YieldType, YieldChange)
VALUES ('BUILDING_HALICARNASSUS_MAUSOLEUM', 'YIELD_CULTURE', 5);
