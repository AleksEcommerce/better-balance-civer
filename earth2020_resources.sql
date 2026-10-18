-- Resource-only compatibility for Earth 2020 Civs.
-- Load after Raubak and BBC resource changes. Only declared replacements are copied.
CREATE TEMP TABLE BBC_Earth2020ResourceUnits (UnitType TEXT PRIMARY KEY);
INSERT INTO BBC_Earth2020ResourceUnits (UnitType) VALUES
    ('UNIT_LEOPARD2'),
    ('UNIT_M1ABRAMS'),
    ('UNIT_T90'),
    ('UNIT_TYPE99'),
    ('UNIT_TYPE90_JAPAN'),
    ('UNIT_CHALLENGER2'),
    ('UNIT_LECLERC'),
    ('UNIT_TAM'),
    ('UNIT_KARRAR'),
    ('UNIT_K2_BLACK_PANTHER'),
    ('UNIT_MERKAVA'),
    ('UNIT_MIL_MI_24'),
    ('UNIT_AH_64_APACHE'),
    ('UNIT_Z_10'),
    ('UNIT_TIGER'),
    ('UNIT_ROOIVALK'),
    ('UNIT_A129_MANGUSTA'),
    ('UNIT_F35_LIGHTNING_II'),
    ('UNIT_CHENGDU_J20'),
    ('UNIT_SUKHOI_SU35'),
    ('UNIT_EUROFIGHTER_TYPHOON'),
    ('UNIT_DASSAULT_RAFALE'),
    ('UNIT_B52_STRATOFORTRESS'),
    ('UNIT_XIAN_H6'),
    ('UNIT_TUPOLEV_TU95'),
    ('UNIT_ARLEIGH_BURKE_CLASS'),
    ('UNIT_TYPE_055_CLASS'),
    ('UNIT_KIROV_CLASS'),
    ('UNIT_KOLKATA_CLASS'),
    ('UNIT_ATAGO_CLASS'),
    ('UNIT_DARING_CLASS'),
    ('UNIT_HORIZON_CLASS'),
    ('UNIT_SEJONG_CLASS'),
    ('UNIT_VIRGINIA_CLASS'),
    ('UNIT_SHANG_CLASS'),
    ('UNIT_AKULA_CLASS'),
    ('UNIT_ARIHANT_CLASS'),
    ('UNIT_ASTUTE_CLASS'),
    ('UNIT_AMETHYSTE_CLASS'),
    ('UNIT_FORD_CARRIER'),
    ('UNIT_SHANDONG_CARRIER'),
    ('UNIT_KUZNETSOV_CARRIER'),
    ('UNIT_ELIZABETH_CARRIER'),
    ('UNIT_DEGAULLE_CARRIER'),
    ('UNIT_DNC1'),
    ('UNIT_MEXICO_NATIONAL_GUARD'),
    ('UNIT_ISRAEL_GOLANI_BRIGADE');

UPDATE Units
SET StrategicResource = (
    SELECT base.StrategicResource FROM UnitReplaces r
    JOIN Units base ON base.UnitType = r.ReplacesUnitType
    WHERE r.CivUniqueUnitType = Units.UnitType
)
WHERE UnitType IN (SELECT UnitType FROM BBC_Earth2020ResourceUnits)
  AND EXISTS (SELECT 1 FROM UnitReplaces r JOIN Units base ON base.UnitType = r.ReplacesUnitType
              WHERE r.CivUniqueUnitType = Units.UnitType);

INSERT OR IGNORE INTO Units_XP2 (UnitType)
SELECT u.UnitType FROM Units u
JOIN BBC_Earth2020ResourceUnits e ON e.UnitType = u.UnitType
JOIN UnitReplaces r ON r.CivUniqueUnitType = u.UnitType
JOIN Units_XP2 base ON base.UnitType = r.ReplacesUnitType;

UPDATE Units_XP2
SET ResourceCost = (SELECT base.ResourceCost FROM UnitReplaces r JOIN Units_XP2 base ON base.UnitType = r.ReplacesUnitType WHERE r.CivUniqueUnitType = Units_XP2.UnitType),
    ResourceMaintenanceType = (SELECT base.ResourceMaintenanceType FROM UnitReplaces r JOIN Units_XP2 base ON base.UnitType = r.ReplacesUnitType WHERE r.CivUniqueUnitType = Units_XP2.UnitType),
    ResourceMaintenanceAmount = (SELECT base.ResourceMaintenanceAmount FROM UnitReplaces r JOIN Units_XP2 base ON base.UnitType = r.ReplacesUnitType WHERE r.CivUniqueUnitType = Units_XP2.UnitType)
WHERE UnitType IN (SELECT UnitType FROM BBC_Earth2020ResourceUnits)
  AND EXISTS (SELECT 1 FROM UnitReplaces r JOIN Units_XP2 base ON base.UnitType = r.ReplacesUnitType
              WHERE r.CivUniqueUnitType = Units_XP2.UnitType);

DROP TABLE BBC_Earth2020ResourceUnits;
