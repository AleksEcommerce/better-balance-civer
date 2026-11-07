-- Observation Units Ignore Rivers, author game (Workshop 2803846980).
INSERT OR IGNORE INTO TypeTags (Type, Tag)
SELECT UnitType, 'CLASS_HELICOPTER' FROM Units
WHERE UnitType IN ('UNIT_OBSERVATION_BALLOON', 'UNIT_DRONE');
