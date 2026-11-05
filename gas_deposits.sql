-- Increase Raubak Natural Gas deposits on newly generated maps.
UPDATE Resources
SET Frequency = 12, SeaFrequency = 11
WHERE ResourceType = 'RESOURCE_GAS';
