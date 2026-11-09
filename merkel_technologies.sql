-- German Technologies: leader-specific plot production, using native modifiers.
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('BBC_MERKEL_STRATEGIC', 'REQUIREMENT_PLOT_RESOURCE_CLASS_TYPE_MATCHES');
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('BBC_MERKEL_STRATEGIC', 'ResourceClassType', 'RESOURCECLASS_STRATEGIC');
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('BBC_MERKEL_MINE_IMPROVEMENT', 'REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES');
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('BBC_MERKEL_MINE_IMPROVEMENT', 'ImprovementType', 'IMPROVEMENT_MINE');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('BBC_MERKEL_MINE_REQS', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('BBC_MERKEL_MINE_REQS', 'BBC_MERKEL_MINE_IMPROVEMENT');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('BBC_MERKEL_MINE_REQS', 'BBC_MERKEL_STRATEGIC');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES ('BBC_MERKEL_MINE', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'BBC_MERKEL_MINE_REQS');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES ('BBC_MERKEL_MINE', 'YieldType', 'YIELD_PRODUCTION'), ('BBC_MERKEL_MINE', 'Amount', 2);
INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId) SELECT TraitType, 'BBC_MERKEL_MINE' FROM Traits WHERE TraitType = 'TRAIT_LEADER_MERKEL';
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('BBC_MERKEL_WELL_IMPROVEMENT', 'REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES');
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('BBC_MERKEL_WELL_IMPROVEMENT', 'ImprovementType', 'IMPROVEMENT_OIL_WELL');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('BBC_MERKEL_WELL_REQS', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('BBC_MERKEL_WELL_REQS', 'BBC_MERKEL_WELL_IMPROVEMENT');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES ('BBC_MERKEL_WELL', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'BBC_MERKEL_WELL_REQS');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES ('BBC_MERKEL_WELL', 'YieldType', 'YIELD_PRODUCTION'), ('BBC_MERKEL_WELL', 'Amount', 2);
INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId) SELECT TraitType, 'BBC_MERKEL_WELL' FROM Traits WHERE TraitType = 'TRAIT_LEADER_MERKEL';
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES ('BBC_MERKEL_RIG_IMPROVEMENT', 'REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES');
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('BBC_MERKEL_RIG_IMPROVEMENT', 'ImprovementType', 'IMPROVEMENT_OFFSHORE_OIL_RIG');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('BBC_MERKEL_RIG_REQS', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('BBC_MERKEL_RIG_REQS', 'BBC_MERKEL_RIG_IMPROVEMENT');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES ('BBC_MERKEL_RIG', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'BBC_MERKEL_RIG_REQS');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES ('BBC_MERKEL_RIG', 'YieldType', 'YIELD_PRODUCTION'), ('BBC_MERKEL_RIG', 'Amount', 2);
INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId) SELECT TraitType, 'BBC_MERKEL_RIG' FROM Traits WHERE TraitType = 'TRAIT_LEADER_MERKEL';

-- Also refresh existing rows when the balance SQL is reapplied.
UPDATE ModifierArguments SET Value = 2
WHERE Name = 'Amount' AND ModifierId IN ('BBC_MERKEL_MINE', 'BBC_MERKEL_WELL', 'BBC_MERKEL_RIG');
