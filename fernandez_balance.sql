-- Reduce both Fernandez governor-title yields from 5% to 3%.
UPDATE ModifierArguments SET Value = 3
WHERE Name = 'Amount' AND ModifierId IN (
    'TRAIT_FERNANDEZ_ADJUST_CITY_GOLD_PER_GOVERNOR_TITLE',
    'TRAIT_FERNANDEZ_ADJUST_CITY_PRODUCTION_PER_GOVERNOR_TITLE'
);
