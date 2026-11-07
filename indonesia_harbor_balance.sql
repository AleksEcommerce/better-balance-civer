-- Earth 2020 Indonesia: +300% production toward Harbor districts.
UPDATE ModifierArguments SET Value = 300
WHERE ModifierId = 'TRAIT_QUINTUPLE_BOOST_HARBOR_PRODUCTION'
  AND Name = 'Amount';
