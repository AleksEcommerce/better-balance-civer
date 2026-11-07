-- Share only May's native Seduction promotion grant with Johnson.
INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId)
SELECT 'TRAIT_LEADER_JOHNSON', 'TRAIT_MAY_GRANT_SPY_PROMOTION'
WHERE EXISTS (SELECT 1 FROM LeaderTraits WHERE LeaderType = 'LEADER_JOHNSON' AND TraitType = 'TRAIT_LEADER_JOHNSON')
  AND EXISTS (SELECT 1 FROM Modifiers WHERE ModifierId = 'TRAIT_MAY_GRANT_SPY_PROMOTION');
