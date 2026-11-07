-- Steel and Thunder: Unique Units - Enable All (Workshop 1832546250).
-- Run between the base mod settings (3) and its filtering (5).
UPDATE ConfigEnabledUniqueUnits SET Enabled = 1;
DELETE FROM UnitsToDelete;
