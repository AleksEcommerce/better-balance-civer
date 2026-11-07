-- Starting Scout (Workshop 872293659): one extra Scout for Ancient-era starts.
INSERT INTO MajorStartingUnits (Era, Unit, NotStartTile)
SELECT 'ERA_ANCIENT', 'UNIT_SCOUT', 1
WHERE NOT EXISTS (
    SELECT 1 FROM MajorStartingUnits
    WHERE Era = 'ERA_ANCIENT' AND Unit = 'UNIT_SCOUT' AND NotStartTile = 1
);
