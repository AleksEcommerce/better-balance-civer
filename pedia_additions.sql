-- Civilopedia additions. Preserve the original text; repeated application is safe.

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]После «Дальней связи»: +5 к боевой мощи и +1 к обзору. Не улучшается в атомную подлодку.' WHERE Language = 'ru_RU' AND Tag IN ('LOC_UNIT_SUBMARINE_DESCRIPTION') AND instr(Text, 'После «Дальней связи»: +5 к боевой мощи и +1 к обзору. Не улучшается в атомную подлодку.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]After Telecommunications: +5 Combat Strength and +1 Sight. Cannot upgrade into a Nuclear Submarine.' WHERE Language = 'en_US' AND Tag IN ('LOC_UNIT_SUBMARINE_DESCRIPTION') AND instr(Text, 'After Telecommunications: +5 Combat Strength and +1 Sight. Cannot upgrade into a Nuclear Submarine.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Не улучшается в атомную подлодку или её уникальные замены.' WHERE Language = 'ru_RU' AND Tag IN ('LOC_UNIT_GERMAN_UBOAT_DESCRIPTION') AND instr(Text, 'Не улучшается в атомную подлодку или её уникальные замены.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Cannot upgrade into a Nuclear Submarine or its unique replacements.' WHERE Language = 'en_US' AND Tag IN ('LOC_UNIT_GERMAN_UBOAT_DESCRIPTION') AND instr(Text, 'Cannot upgrade into a Nuclear Submarine or its unique replacements.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]После «Дальней связи»: +1 к обзору.' WHERE Language = 'ru_RU' AND Tag IN ('LOC_UNIT_DESTROYER_DESCRIPTION') AND instr(Text, 'После «Дальней связи»: +1 к обзору.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]After Telecommunications: +1 Sight.' WHERE Language = 'en_US' AND Tag IN ('LOC_UNIT_DESTROYER_DESCRIPTION') AND instr(Text, 'After Telecommunications: +1 Sight.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Содержание — 12 золота и 1 уран за ход. Ресурсная стоимость постройки наследуется от обычной подлодки (30 железа при включённом Raubak, стандартная скорость).' WHERE Language = 'ru_RU' AND Tag IN ('LOC_UNIT_AKULA_CLASS_DESCRIPTION','LOC_UNIT_AMETHYSTE_CLASS_DESCRIPTION','LOC_UNIT_ARIHANT_CLASS_DESCRIPTION','LOC_UNIT_ASTUTE_CLASS_DESCRIPTION','LOC_UNIT_NUCLEAR_SUBMARINE_DESCRIPTION','LOC_UNIT_SHANG_CLASS_DESCRIPTION','LOC_UNIT_VIRGINIA_CLASS_DESCRIPTION') AND instr(Text, 'Содержание — 12 золота и 1 уран за ход. Ресурсная стоимость постройки наследуется от обычной подлодки (30 железа при включённом Raubak, стандартная скорость).') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Upkeep: 12 Gold and 1 Uranium per turn. Construction resource cost follows the Submarine (30 Iron with Raubak enabled, Standard speed).' WHERE Language = 'en_US' AND Tag IN ('LOC_UNIT_AKULA_CLASS_DESCRIPTION','LOC_UNIT_AMETHYSTE_CLASS_DESCRIPTION','LOC_UNIT_ARIHANT_CLASS_DESCRIPTION','LOC_UNIT_ASTUTE_CLASS_DESCRIPTION','LOC_UNIT_NUCLEAR_SUBMARINE_DESCRIPTION','LOC_UNIT_SHANG_CLASS_DESCRIPTION','LOC_UNIT_VIRGINIA_CLASS_DESCRIPTION') AND instr(Text, 'Upkeep: 12 Gold and 1 Uranium per turn. Construction resource cost follows the Submarine (30 Iron with Raubak enabled, Standard speed).') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Дальность обстрела — не менее 4 клеток.' WHERE Language = 'ru_RU' AND Tag IN ('LOC_UNIT_ARLEIGH_BURKE_CLASS_DESCRIPTION','LOC_UNIT_ATAGO_CLASS_DESCRIPTION','LOC_UNIT_DARING_CLASS_DESCRIPTION','LOC_UNIT_HORIZON_CLASS_DESCRIPTION','LOC_UNIT_KIROV_CLASS_DESCRIPTION','LOC_UNIT_KOLKATA_CLASS_DESCRIPTION','LOC_UNIT_MISSILE_CRUISER_DESCRIPTION','LOC_UNIT_SEJONG_CLASS_DESCRIPTION','LOC_UNIT_TYPE_055_CLASS_DESCRIPTION') AND instr(Text, 'Дальность обстрела — не менее 4 клеток.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Attack Range: at least 4 tiles.' WHERE Language = 'en_US' AND Tag IN ('LOC_UNIT_ARLEIGH_BURKE_CLASS_DESCRIPTION','LOC_UNIT_ATAGO_CLASS_DESCRIPTION','LOC_UNIT_DARING_CLASS_DESCRIPTION','LOC_UNIT_HORIZON_CLASS_DESCRIPTION','LOC_UNIT_KIROV_CLASS_DESCRIPTION','LOC_UNIT_KOLKATA_CLASS_DESCRIPTION','LOC_UNIT_MISSILE_CRUISER_DESCRIPTION','LOC_UNIT_SEJONG_CLASS_DESCRIPTION','LOC_UNIT_TYPE_055_CLASS_DESCRIPTION') AND instr(Text, 'Attack Range: at least 4 tiles.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Передаёт свою скорость движения связанным с ним юнитам сопровождения.' WHERE Language = 'ru_RU' AND Tag IN ('LOC_UNIT_ARLEIGH_BURKE_CLASS_DESCRIPTION','LOC_UNIT_ATAGO_CLASS_DESCRIPTION','LOC_UNIT_BATTLESHIP_DESCRIPTION','LOC_UNIT_BRAZILIAN_MINAS_GERAES_DESCRIPTION','LOC_UNIT_BYZANTINE_DROMON_DESCRIPTION','LOC_UNIT_CANADA_HMCS_HAIDA_DESCRIPTION','LOC_UNIT_CARAVEL_DESCRIPTION','LOC_UNIT_COG_DESCRIPTION','LOC_UNIT_DARING_CLASS_DESCRIPTION','LOC_UNIT_DESTROYER_DESCRIPTION','LOC_UNIT_DE_ZEVEN_PROVINCIEN_DESCRIPTION','LOC_UNIT_EGYPTIAN_WAR_GALLEY_DESCRIPTION','LOC_UNIT_ENGLISH_SHIP_OF_THE_LINE_DESCRIPTION','LOC_UNIT_FRIGATE_DESCRIPTION','LOC_UNIT_GALLEASS_DESCRIPTION','LOC_UNIT_GALLEY_DESCRIPTION','LOC_UNIT_HORIZON_CLASS_DESCRIPTION','LOC_UNIT_INDONESIAN_JONG_DESCRIPTION','LOC_UNIT_IRONCLAD_DESCRIPTION','LOC_UNIT_JAPANESE_YAMATO_DESCRIPTION','LOC_UNIT_KHMER_WAR_CANOE_DESCRIPTION','LOC_UNIT_KIROV_CLASS_DESCRIPTION','LOC_UNIT_KOLKATA_CLASS_DESCRIPTION','LOC_UNIT_KOREAN_TURTLE_SHIP_DESCRIPTION','LOC_UNIT_MISSILE_CRUISER_DESCRIPTION','LOC_UNIT_NORWEGIAN_LONGSHIP_DESCRIPTION','LOC_UNIT_PERSIAN_WARSHIP_DESCRIPTION','LOC_UNIT_PHOENICIA_BIREME_DESCRIPTION','LOC_UNIT_PORTUGUESE_NAU_DESCRIPTION','LOC_UNIT_QUADRIREME_DESCRIPTION','LOC_UNIT_SEJONG_CLASS_DESCRIPTION','LOC_UNIT_TYPE_055_CLASS_DESCRIPTION') AND instr(Text, 'Передаёт свою скорость движения связанным с ним юнитам сопровождения.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Shares its movement speed with linked escort units.' WHERE Language = 'en_US' AND Tag IN ('LOC_UNIT_ARLEIGH_BURKE_CLASS_DESCRIPTION','LOC_UNIT_ATAGO_CLASS_DESCRIPTION','LOC_UNIT_BATTLESHIP_DESCRIPTION','LOC_UNIT_BRAZILIAN_MINAS_GERAES_DESCRIPTION','LOC_UNIT_BYZANTINE_DROMON_DESCRIPTION','LOC_UNIT_CANADA_HMCS_HAIDA_DESCRIPTION','LOC_UNIT_CARAVEL_DESCRIPTION','LOC_UNIT_COG_DESCRIPTION','LOC_UNIT_DARING_CLASS_DESCRIPTION','LOC_UNIT_DESTROYER_DESCRIPTION','LOC_UNIT_DE_ZEVEN_PROVINCIEN_DESCRIPTION','LOC_UNIT_EGYPTIAN_WAR_GALLEY_DESCRIPTION','LOC_UNIT_ENGLISH_SHIP_OF_THE_LINE_DESCRIPTION','LOC_UNIT_FRIGATE_DESCRIPTION','LOC_UNIT_GALLEASS_DESCRIPTION','LOC_UNIT_GALLEY_DESCRIPTION','LOC_UNIT_HORIZON_CLASS_DESCRIPTION','LOC_UNIT_INDONESIAN_JONG_DESCRIPTION','LOC_UNIT_IRONCLAD_DESCRIPTION','LOC_UNIT_JAPANESE_YAMATO_DESCRIPTION','LOC_UNIT_KHMER_WAR_CANOE_DESCRIPTION','LOC_UNIT_KIROV_CLASS_DESCRIPTION','LOC_UNIT_KOLKATA_CLASS_DESCRIPTION','LOC_UNIT_KOREAN_TURTLE_SHIP_DESCRIPTION','LOC_UNIT_MISSILE_CRUISER_DESCRIPTION','LOC_UNIT_NORWEGIAN_LONGSHIP_DESCRIPTION','LOC_UNIT_PERSIAN_WARSHIP_DESCRIPTION','LOC_UNIT_PHOENICIA_BIREME_DESCRIPTION','LOC_UNIT_PORTUGUESE_NAU_DESCRIPTION','LOC_UNIT_QUADRIREME_DESCRIPTION','LOC_UNIT_SEJONG_CLASS_DESCRIPTION','LOC_UNIT_TYPE_055_CLASS_DESCRIPTION') AND instr(Text, 'Shares its movement speed with linked escort units.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Открывается на «Радио». Боевая мощь — 70, сила обстрела — 65; после «Спутников» — 75 и 70 соответственно. Базовая стоимость — 500 производства. Дальность десантирования — 10 клеток, увеличенная дальность с подходящей авиабазы — 12.' WHERE Language = 'ru_RU' AND Tag IN ('LOC_UNIT_SPEC_OPS_DESCRIPTION') AND instr(Text, 'Открывается на «Радио». Боевая мощь — 70, сила обстрела — 65; после «Спутников» — 75 и 70 соответственно. Базовая стоимость — 500 производства. Дальность десантирования — 10 клеток, увеличенная дальность с подходящей авиабазы — 12.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Unlocked at Radio. Combat/Ranged Strength: 70/65, increasing to 75/70 after Satellites. Base Production cost: 500. Paradrop range: 10 tiles; extended range from a suitable air base: 12.' WHERE Language = 'en_US' AND Tag IN ('LOC_UNIT_SPEC_OPS_DESCRIPTION') AND instr(Text, 'Unlocked at Radio. Combat/Ranged Strength: 70/65, increasing to 75/70 after Satellites. Base Production cost: 500. Paradrop range: 10 tiles; extended range from a suitable air base: 12.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Боевая мощь — 70, сила обстрела — 65. Не расходует нефть на содержание.' WHERE Language = 'ru_RU' AND Tag IN ('LOC_UNIT_BIPLANE_DESCRIPTION') AND instr(Text, 'Боевая мощь — 70, сила обстрела — 65. Не расходует нефть на содержание.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Combat Strength 70, Ranged Strength 65. No Oil upkeep.' WHERE Language = 'en_US' AND Tag IN ('LOC_UNIT_BIPLANE_DESCRIPTION') AND instr(Text, 'Combat Strength 70, Ranged Strength 65. No Oil upkeep.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Дальность обстрела — 3 клетки. Базовое движение с поправками Better Balance Civer — 2.' WHERE Language = 'ru_RU' AND Tag IN ('LOC_UNIT_ARTILLERY_DESCRIPTION') AND instr(Text, 'Дальность обстрела — 3 клетки. Базовое движение с поправками Better Balance Civer — 2.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Attack Range: 3. Base Movement with Better Balance Civer adjustments: 2.' WHERE Language = 'en_US' AND Tag IN ('LOC_UNIT_ARTILLERY_DESCRIPTION') AND instr(Text, 'Attack Range: 3. Base Movement with Better Balance Civer adjustments: 2.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Сила обстрела — 90. Базовое движение — 4. Требует 40 селитры для постройки на стандартной скорости.' WHERE Language = 'ru_RU' AND Tag IN ('LOC_UNIT_SELF_PROPELLED_ARTILLERY_DESCRIPTION') AND instr(Text, 'Сила обстрела — 90. Базовое движение — 4. Требует 40 селитры для постройки на стандартной скорости.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Ranged Strength: 90. Base Movement: 4. Requires 40 Niter to build on Standard speed.' WHERE Language = 'en_US' AND Tag IN ('LOC_UNIT_SELF_PROPELLED_ARTILLERY_DESCRIPTION') AND instr(Text, 'Ranged Strength: 90. Base Movement: 4. Requires 40 Niter to build on Standard speed.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Повышение «Подавление» увеличивает дальность обстрела на 1 вместо добавления зоны контроля. Исходная зона контроля юнита сохраняется.' WHERE Language = 'ru_RU' AND Tag IN ('LOC_UNIT_MACHINE_GUN_DESCRIPTION') AND instr(Text, 'Повышение «Подавление» увеличивает дальность обстрела на 1 вместо добавления зоны контроля. Исходная зона контроля юнита сохраняется.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]The Suppression promotion grants +1 Range instead of adding Zone of Control. The unit retains its innate Zone of Control.' WHERE Language = 'en_US' AND Tag IN ('LOC_UNIT_MACHINE_GUN_DESCRIPTION') AND instr(Text, 'The Suppression promotion grants +1 Range instead of adding Zone of Control. The unit retains its innate Zone of Control.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Повышение «Подавление» увеличивает дальность обстрела на 1 вместо добавления зоны контроля. Исходная зона контроля юнита сохраняется.' WHERE Language = 'ru_RU' AND Tag IN ('LOC_UNIT_GATLING_GUN_DESCRIPTION') AND instr(Text, 'Повышение «Подавление» увеличивает дальность обстрела на 1 вместо добавления зоны контроля. Исходная зона контроля юнита сохраняется.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]The Suppression promotion grants +1 Range instead of adding Zone of Control. The unit retains its innate Zone of Control.' WHERE Language = 'en_US' AND Tag IN ('LOC_UNIT_GATLING_GUN_DESCRIPTION') AND instr(Text, 'The Suppression promotion grants +1 Range instead of adding Zone of Control. The unit retains its innate Zone of Control.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Может потратить заряд на 10% строительства акведука или пригорода; для их уникальных замен — 20%. Автоматическая прокладка дорог стоит 2 золота за клетку и не расходует строительные заряды.' WHERE Language = 'ru_RU' AND Tag IN ('LOC_UNIT_BUILDER_DESCRIPTION') AND instr(Text, 'Может потратить заряд на 10% строительства акведука или пригорода; для их уникальных замен — 20%. Автоматическая прокладка дорог стоит 2 золота за клетку и не расходует строительные заряды.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Can spend a charge to complete 10% of an Aqueduct or Neighborhood, or 20% of a unique replacement. Automated road construction costs 2 Gold per tile and does not consume build charges.' WHERE Language = 'en_US' AND Tag IN ('LOC_UNIT_BUILDER_DESCRIPTION') AND instr(Text, 'Can spend a charge to complete 10% of an Aqueduct or Neighborhood, or 20% of a unique replacement. Automated road construction costs 2 Gold per tile and does not consume build charges.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Получает +1 строительный заряд. Автоматическое строительство железных дорог после «Паровой машины» требует 1 железо и 1 уголь за клетку и не расходует строительные заряды.' WHERE Language = 'ru_RU' AND Tag IN ('LOC_UNIT_MILITARY_ENGINEER_ALT_DESCRIPTION') AND instr(Text, 'Получает +1 строительный заряд. Автоматическое строительство железных дорог после «Паровой машины» требует 1 железо и 1 уголь за клетку и не расходует строительные заряды.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Receives +1 build charge. Automated railroad construction after Steam Power costs 1 Iron and 1 Coal per tile and does not consume build charges.' WHERE Language = 'en_US' AND Tag IN ('LOC_UNIT_MILITARY_ENGINEER_ALT_DESCRIPTION') AND instr(Text, 'Receives +1 build charge. Automated railroad construction after Steam Power costs 1 Iron and 1 Coal per tile and does not consume build charges.') = 0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Стоимость постройки на стандартной скорости — 10 селитры. Ресурсное содержание сохраняется.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_AUSTRALIAN_SASR_DESCRIPTION' AND instr(Text,'Стоимость постройки на стандартной скорости — 10 селитры. Ресурсное содержание сохраняется.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Construction cost on Standard speed: 10 Niter. Resource upkeep is unchanged.' WHERE Language='en_US' AND Tag='LOC_UNIT_AUSTRALIAN_SASR_DESCRIPTION' AND instr(Text,'Construction cost on Standard speed: 10 Niter. Resource upkeep is unchanged.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Стоимость постройки на стандартной скорости — 10 селитры. Ресурсное содержание сохраняется.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_KONGO_GARDE_REPUBLICAINE_DESCRIPTION' AND instr(Text,'Стоимость постройки на стандартной скорости — 10 селитры. Ресурсное содержание сохраняется.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Construction cost on Standard speed: 10 Niter. Resource upkeep is unchanged.' WHERE Language='en_US' AND Tag='LOC_UNIT_KONGO_GARDE_REPUBLICAINE_DESCRIPTION' AND instr(Text,'Construction cost on Standard speed: 10 Niter. Resource upkeep is unchanged.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Стоимость постройки на стандартной скорости — 3 селитры. Ресурсное содержание сохраняется.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_BRAZILIAN_BANDEIRANTE_DESCRIPTION' AND instr(Text,'Стоимость постройки на стандартной скорости — 3 селитры. Ресурсное содержание сохраняется.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Construction cost on Standard speed: 3 Niter. Resource upkeep is unchanged.' WHERE Language='en_US' AND Tag='LOC_UNIT_BRAZILIAN_BANDEIRANTE_DESCRIPTION' AND instr(Text,'Construction cost on Standard speed: 3 Niter. Resource upkeep is unchanged.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Стоимость постройки на стандартной скорости — 5 селитры. Ресурсное содержание сохраняется.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_GATLING_GUN_DESCRIPTION' AND instr(Text,'Стоимость постройки на стандартной скорости — 5 селитры. Ресурсное содержание сохраняется.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Construction cost on Standard speed: 5 Niter. Resource upkeep is unchanged.' WHERE Language='en_US' AND Tag='LOC_UNIT_GATLING_GUN_DESCRIPTION' AND instr(Text,'Construction cost on Standard speed: 5 Niter. Resource upkeep is unchanged.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Может потратить строительный заряд на 30% строительства военного лагеря.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_ROMAN_LEGION_DESCRIPTION' AND instr(Text,'Может потратить строительный заряд на 30% строительства военного лагеря.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Can spend a build charge to complete 30% of an Encampment.' WHERE Language='en_US' AND Tag='LOC_UNIT_ROMAN_LEGION_DESCRIPTION' AND instr(Text,'Can spend a build charge to complete 30% of an Encampment.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Может потратить строительный заряд на 30% строительства военного лагеря.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_MAORI_TOA_DESCRIPTION' AND instr(Text,'Может потратить строительный заряд на 30% строительства военного лагеря.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Can spend a build charge to complete 30% of an Encampment.' WHERE Language='en_US' AND Tag='LOC_UNIT_MAORI_TOA_DESCRIPTION' AND instr(Text,'Can spend a build charge to complete 30% of an Encampment.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Получает +1 религиозный заряд.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_MISSIONARY_DESCRIPTION' AND instr(Text,'Получает +1 религиозный заряд.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Receives +1 religious charge.' WHERE Language='en_US' AND Tag='LOC_UNIT_MISSIONARY_DESCRIPTION' AND instr(Text,'Receives +1 religious charge.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Получает +1 религиозный заряд.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_INQUISITOR_EXPANSION2_DESCRIPTION' AND instr(Text,'Получает +1 религиозный заряд.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Receives +1 religious charge.' WHERE Language='en_US' AND Tag='LOC_UNIT_INQUISITOR_EXPANSION2_DESCRIPTION' AND instr(Text,'Receives +1 religious charge.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Боевая мощь после ребаланса — 93. Базовая стоимость — 640 производства. Уникальные способности сохранены.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_T90_DESCRIPTION' AND instr(Text,'Боевая мощь после ребаланса — 93. Базовая стоимость — 640 производства. Уникальные способности сохранены.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Rebalanced Combat Strength: 93. Base Production cost: 640. Unique abilities are preserved.' WHERE Language='en_US' AND Tag='LOC_UNIT_T90_DESCRIPTION' AND instr(Text,'Rebalanced Combat Strength: 93. Base Production cost: 640. Unique abilities are preserved.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Боевая мощь после ребаланса — 90. Базовая стоимость — 600 производства. Уникальные способности сохранены.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_TAM_DESCRIPTION' AND instr(Text,'Боевая мощь после ребаланса — 90. Базовая стоимость — 600 производства. Уникальные способности сохранены.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Rebalanced Combat Strength: 90. Base Production cost: 600. Unique abilities are preserved.' WHERE Language='en_US' AND Tag='LOC_UNIT_TAM_DESCRIPTION' AND instr(Text,'Rebalanced Combat Strength: 90. Base Production cost: 600. Unique abilities are preserved.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Боевая мощь после ребаланса — 95. Базовая стоимость — 700 производства. Уникальные способности сохранены.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_TYPE99_DESCRIPTION' AND instr(Text,'Боевая мощь после ребаланса — 95. Базовая стоимость — 700 производства. Уникальные способности сохранены.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Rebalanced Combat Strength: 95. Base Production cost: 700. Unique abilities are preserved.' WHERE Language='en_US' AND Tag='LOC_UNIT_TYPE99_DESCRIPTION' AND instr(Text,'Rebalanced Combat Strength: 95. Base Production cost: 700. Unique abilities are preserved.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Боевая мощь после ребаланса — 95. Базовая стоимость — 700 производства. Уникальные способности сохранены.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_KARRAR_DESCRIPTION' AND instr(Text,'Боевая мощь после ребаланса — 95. Базовая стоимость — 700 производства. Уникальные способности сохранены.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Rebalanced Combat Strength: 95. Base Production cost: 700. Unique abilities are preserved.' WHERE Language='en_US' AND Tag='LOC_UNIT_KARRAR_DESCRIPTION' AND instr(Text,'Rebalanced Combat Strength: 95. Base Production cost: 700. Unique abilities are preserved.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Боевая мощь после ребаланса — 95. Базовая стоимость — 720 производства. Уникальные способности сохранены.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_TYPE90_JAPAN_DESCRIPTION' AND instr(Text,'Боевая мощь после ребаланса — 95. Базовая стоимость — 720 производства. Уникальные способности сохранены.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Rebalanced Combat Strength: 95. Base Production cost: 720. Unique abilities are preserved.' WHERE Language='en_US' AND Tag='LOC_UNIT_TYPE90_JAPAN_DESCRIPTION' AND instr(Text,'Rebalanced Combat Strength: 95. Base Production cost: 720. Unique abilities are preserved.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Боевая мощь после ребаланса — 95. Базовая стоимость — 720 производства. Уникальные способности сохранены.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_LECLERC_DESCRIPTION' AND instr(Text,'Боевая мощь после ребаланса — 95. Базовая стоимость — 720 производства. Уникальные способности сохранены.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Rebalanced Combat Strength: 95. Base Production cost: 720. Unique abilities are preserved.' WHERE Language='en_US' AND Tag='LOC_UNIT_LECLERC_DESCRIPTION' AND instr(Text,'Rebalanced Combat Strength: 95. Base Production cost: 720. Unique abilities are preserved.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Боевая мощь после ребаланса — 95. Базовая стоимость — 720 производства. Уникальные способности сохранены.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_MERKAVA_DESCRIPTION' AND instr(Text,'Боевая мощь после ребаланса — 95. Базовая стоимость — 720 производства. Уникальные способности сохранены.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Rebalanced Combat Strength: 95. Base Production cost: 720. Unique abilities are preserved.' WHERE Language='en_US' AND Tag='LOC_UNIT_MERKAVA_DESCRIPTION' AND instr(Text,'Rebalanced Combat Strength: 95. Base Production cost: 720. Unique abilities are preserved.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Боевая мощь после ребаланса — 86. Базовая стоимость — 600 производства. Уникальные способности сохранены.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_MIL_MI_24_DESCRIPTION' AND instr(Text,'Боевая мощь после ребаланса — 86. Базовая стоимость — 600 производства. Уникальные способности сохранены.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Rebalanced Combat Strength: 86. Base Production cost: 600. Unique abilities are preserved.' WHERE Language='en_US' AND Tag='LOC_UNIT_MIL_MI_24_DESCRIPTION' AND instr(Text,'Rebalanced Combat Strength: 86. Base Production cost: 600. Unique abilities are preserved.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Боевая мощь после ребаланса — 90. Базовая стоимость — 630 производства. Уникальные способности сохранены.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_AH_64_APACHE_DESCRIPTION' AND instr(Text,'Боевая мощь после ребаланса — 90. Базовая стоимость — 630 производства. Уникальные способности сохранены.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Rebalanced Combat Strength: 90. Base Production cost: 630. Unique abilities are preserved.' WHERE Language='en_US' AND Tag='LOC_UNIT_AH_64_APACHE_DESCRIPTION' AND instr(Text,'Rebalanced Combat Strength: 90. Base Production cost: 630. Unique abilities are preserved.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Боевая мощь после ребаланса — 86. Базовая стоимость — 600 производства. Уникальные способности сохранены.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_Z_10_DESCRIPTION' AND instr(Text,'Боевая мощь после ребаланса — 86. Базовая стоимость — 600 производства. Уникальные способности сохранены.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Rebalanced Combat Strength: 86. Base Production cost: 600. Unique abilities are preserved.' WHERE Language='en_US' AND Tag='LOC_UNIT_Z_10_DESCRIPTION' AND instr(Text,'Rebalanced Combat Strength: 86. Base Production cost: 600. Unique abilities are preserved.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Боевая мощь после ребаланса — 88. Базовая стоимость — 630 производства. Уникальные способности сохранены.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_TIGER_DESCRIPTION' AND instr(Text,'Боевая мощь после ребаланса — 88. Базовая стоимость — 630 производства. Уникальные способности сохранены.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Rebalanced Combat Strength: 88. Base Production cost: 630. Unique abilities are preserved.' WHERE Language='en_US' AND Tag='LOC_UNIT_TIGER_DESCRIPTION' AND instr(Text,'Rebalanced Combat Strength: 88. Base Production cost: 630. Unique abilities are preserved.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Боевая мощь после ребаланса — 86. Базовая стоимость — 600 производства. Уникальные способности сохранены.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_ROOIVALK_DESCRIPTION' AND instr(Text,'Боевая мощь после ребаланса — 86. Базовая стоимость — 600 производства. Уникальные способности сохранены.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Rebalanced Combat Strength: 86. Base Production cost: 600. Unique abilities are preserved.' WHERE Language='en_US' AND Tag='LOC_UNIT_ROOIVALK_DESCRIPTION' AND instr(Text,'Rebalanced Combat Strength: 86. Base Production cost: 600. Unique abilities are preserved.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Боевая мощь после ребаланса — 86. Базовая стоимость — 570 производства. Уникальные способности сохранены.' WHERE Language='ru_RU' AND Tag='LOC_UNIT_A129_MANGUSTA_DESCRIPTION' AND instr(Text,'Боевая мощь после ребаланса — 86. Базовая стоимость — 570 производства. Уникальные способности сохранены.')=0;

UPDATE LocalizedText SET Text = Text || '[NEWLINE][NEWLINE]Rebalanced Combat Strength: 86. Base Production cost: 570. Unique abilities are preserved.' WHERE Language='en_US' AND Tag='LOC_UNIT_A129_MANGUSTA_DESCRIPTION' AND instr(Text,'Rebalanced Combat Strength: 86. Base Production cost: 570. Unique abilities are preserved.')=0;
