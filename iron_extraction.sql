-- Improved iron deposits accumulate 3 iron per turn instead of the standard 2.
-- Does not change map deposits, tile yields or resource upkeep.
UPDATE Resource_Consumption SET ImprovedExtractionRate = 3
WHERE ResourceType = 'RESOURCE_IRON';
