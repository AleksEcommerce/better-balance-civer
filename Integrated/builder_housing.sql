-- UC - Builder Charges for Housing, author JNR (Workshop 1738051804).
-- BBH_Districts
-- Author: JNR
--------------------------------------------------------------

-- District_BuildChargeProductions
--------------------------------------------------------------
INSERT OR REPLACE INTO District_BuildChargeProductions
		(DistrictType,				UnitType,		PercentProductionPerCharge)
VALUES	('DISTRICT_AQUEDUCT',		'UNIT_BUILDER',	10),
		('DISTRICT_NEIGHBORHOOD',	'UNIT_BUILDER',	10);

INSERT OR REPLACE INTO District_BuildChargeProductions
		(DistrictType,				UnitType,		PercentProductionPerCharge)
SELECT	a.CivUniqueDistrictType,	b.UnitType,		b.PercentProductionPerCharge*2
FROM DistrictReplaces a, District_BuildChargeProductions b WHERE a.ReplacesDistrictType='DISTRICT_AQUEDUCT' AND b.DistrictType='DISTRICT_AQUEDUCT';

INSERT OR REPLACE INTO District_BuildChargeProductions
		(DistrictType,				UnitType,		PercentProductionPerCharge)
SELECT	a.CivUniqueDistrictType,	b.UnitType,		b.PercentProductionPerCharge*2
FROM DistrictReplaces a, District_BuildChargeProductions b WHERE a.ReplacesDistrictType='DISTRICT_NEIGHBORHOOD' AND b.DistrictType='DISTRICT_NEIGHBORHOOD';
--------------------------------------------------------------
-- BBH_Uniques
-- Author: JNR
--------------------------------------------------------------

-- District_BuildChargeProductions
--------------------------------------------------------------
INSERT OR REPLACE INTO District_BuildChargeProductions
		(DistrictType,				UnitType,				PercentProductionPerCharge)
VALUES	('DISTRICT_ENCAMPMENT',		'UNIT_ROMAN_LEGION',	30),
		('DISTRICT_ENCAMPMENT',		'UNIT_MAORI_TOA',		30);
--------------------------------------------------------------