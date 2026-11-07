-- Remove only Pena Nieto's Industrial Zone construction bonus.
-- The shared modifier remains available to other leaders.
DELETE FROM TraitModifiers
WHERE TraitType = 'TRAIT_LEADER_PENA_NIETO'
  AND ModifierId = 'TRAIT_BOOST_INDUSTRIAL_ZONE_PRODUCTION';
