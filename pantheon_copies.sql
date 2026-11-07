-- Two additional copies per pantheon. Snapshot originals before inserting copies.
CREATE TEMP TABLE BBC_PantheonOriginals AS
SELECT * FROM Beliefs WHERE BeliefClassType = 'BELIEF_CLASS_PANTHEON'
AND BeliefType NOT GLOB '*_BBC_COPY_[12]';

INSERT OR IGNORE INTO Types (Type, Kind)
SELECT BeliefType || '_BBC_COPY_' || n.CopyNumber, 'KIND_BELIEF'
FROM BBC_PantheonOriginals CROSS JOIN (SELECT 1 AS CopyNumber UNION ALL SELECT 2) n;

INSERT OR IGNORE INTO Beliefs (BeliefType, Name, Description, BeliefClassType)
SELECT BeliefType || '_BBC_COPY_' || n.CopyNumber, Name, Description, BeliefClassType
FROM BBC_PantheonOriginals CROSS JOIN (SELECT 1 AS CopyNumber UNION ALL SELECT 2) n;

INSERT OR IGNORE INTO BeliefModifiers (BeliefType, ModifierID)
SELECT b.BeliefType || '_BBC_COPY_' || n.CopyNumber, m.ModifierID
FROM BBC_PantheonOriginals b JOIN BeliefModifiers m ON m.BeliefType = b.BeliefType
CROSS JOIN (SELECT 1 AS CopyNumber UNION ALL SELECT 2) n;

DROP TABLE BBC_PantheonOriginals;
