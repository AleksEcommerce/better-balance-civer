-- Integrated from Workshop 3147392979.
-- ASNPP.sql
-- Author: Epoloch
-- DateCreated: 2024-01-25 19:00:26
--------------------------------------------------------------
UPDATE Buildings_XP2 SET NuclearReactor = 0 WHERE BuildingType = 'BUILDING_POWER_PLANT';
DELETE FROM Projects WHERE ProjectType = 'PROJECT_RECOMMISSION_REACTOR';