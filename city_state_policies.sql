-- Reduce the culture/science policy bonus per suzerained city-state to 3%.
UPDATE ModifierArguments SET Value = 3
WHERE Name = 'Amount'
  AND ModifierId IN ('COLLECTIVEACTIVISM_CULTUREPERTRIBUTARY',
                     'INTERNATIONALSPACEAGENCY_SCIENCEPERTRIBUTARY');
