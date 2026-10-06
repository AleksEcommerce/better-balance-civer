-- Мавзолей в Галикарнасе не даёт великим инженерам дополнительный заряд.
DELETE FROM BuildingModifiers
WHERE BuildingType = 'BUILDING_HALICARNASSUS_MAUSOLEUM'
AND ModifierId = 'HALICARNASSUS_ADJUST_ENGINEER_CHARGES';
