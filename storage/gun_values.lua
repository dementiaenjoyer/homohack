--// Credits to @m1ckgordon for the values 🙂

local gun_values = {
    penetration_depth = {
        ["AK12"] = 1.00,
        ["AN-94"] = 1.00,
        ["REMINGTON700"] = 3.00,
        ["ASVAL"] = 1.00,
        ["SCAR-L"] = 1.00,
        ["AUGA1"] = 1.00,
        ["M16A4"] = 1.10,
        ["G36"] = 1.30,
        ["M16A1"] = 0.80,
        ["M16A3"] = 1.10,
        ["TYPE20"] = 1.40,
        ["AUGA2"] = 1.00,
        ["K2"] = 1.00,
        ["FAMASF1"] = 1.00,
        ["AK47"] = 1.40,
        ["AKM"] = 1.40,
        ["AK103"] = 1.40,
        ["TAR-21"] = 1.20,
        ["TYPE88"] = 0.90,
        ["M231"] = 1.00,
        ["C7A2"] = 0.90,
        ["STG-44"] = 1.60,
        ["G11K2"] = 2.00,
        ["M14"] = 1.80,
        ["BEOWULFECR"] = 1.90,
        ["SCAR-H"] = 1.50,
        ["AK12BR"] = 2.00,
        ["G3A3"] = 1.50,
        ["AG-3"] = 2.00,
        ["HK417"] = 1.60,
        ["HENRY45-70"] = 2.00,
        ["FAL50.00"] = 2.00,
        ["HCAR"] = 2.20,
        ["M4A1"] = 1.00,
        ["G36K"] = 1.10,
        ["M4"] = 1.00,
        ["L22"] = 0.90,
        ["SCARPDW"] = 0.90,
        ["AKU12"] = 1.00,
        ["GROZA-1"] = 1.50,
        ["OTS-126"] = 1.20,
        ["AK12C"] = 1.20,
        ["HONEYBADGER"] = 1.30,
        ["K1A"] = 0.75,
        ["SR-3M"] = 1.00,
        ["GROZA-4"] = 1.50,
        ["MC51"] = 1.50,
        ["FAL50.63PARA"] = 2.00,
        ["1858CARBINE"] = 0.50,
        ["AK105"] = 1.00,
        ["JURY"] = 1.00,
        ["KACSRR"] = 1.00,
        ["GYROJETCARBINE"] = 0.70,
        ["C8A2"] = 0.80,
        ["X95R"] = 1.00,
        ["HK51B"] = 1.90,
        ["CANCANNON"] = 1.20,
        ["KSG12"] = 0.40,
        ["MODEL870"] = 0.50,
        ["DBV12"] = 0.50,
        ["KS-23M"] = 0.70,
        ["SAIGA-12"] = 0.50,
        ["STEVENSDB"] = 0.50,
        ["E-GUN"] = 0.50,
        ["AA-12"] = 0.30,
        ["SPAS-12"] = 0.60,
        ["DT11"] = 0.70,
        ["USAS-12"] = 0.30,
        ["MK11"] = 1.70,
        ["SKS"] = 1.50,
        ["SL-8"] = 1.30,
        ["DRAGUNOVSVU"] = 2.80,
        ["VSSVINTOREZ"] = 1.50,
        ["MSG90"] = 2.00,
        ["M21"] = 2.40,
        ["BEOWULFTCR"] = 3.00,
        ["SA58SPR"] = 2.00,
        ["SCARSSR"] = 2.60,
        ["COLTLMG"] = 1.40,
        ["M60"] = 2.20,
        ["AUGHBAR"] = 1.60,
        ["MG36"] = 1.80,
        ["RPK12"] = 1.60,
        ["L86LSW"] = 1.60,
        ["RPK"] = 1.60,
        ["HK21E"] = 1.60,
        ["HAMRIAR"] = 1.40,
        ["RPK74"] = 1.20,
        ["MG3KWS"] = 1.80,
        ["M1918A2"] = 2.20,
        ["MGV-176"] = 0.50,
        ["STONER96"] = 1.20,
        ["CHAINSAW"] = 1.20,
        ["MG42"] = 2.00,
        ["INTERVENTION"] = 4.00,
        ["MODEL700"] = 3.00,
        ["AWS"] = 2.00,
        ["BFG50"] = 10.00,
        ["AWM"] = 3.00,
        ["TRG-42"] = 3.00,
        ["MOSINNAGANT"] = 3.50,
        ["DRAGUNOVSVDS"] = 3.20,
        ["M1903"] = 3.80,
        ["K14"] = 3.00,
        ["HECATEII"] = 10.00,
        ["FT300"] = 3.00,
        ["M107"] = 5.00,
        ["STEYRSCOUT"] = 3.00,
        ["WA2000"] = 2.80,
        ["NTW-20"] = 20.00,
        ["M9"] = 0.50,
        ["G17"] = 0.50,
        ["M1911A1"] = 0.50,
        ["M17"] = 0.50,
        ["DESERTEAGLEL5"] = 1.00,
        ["G21"] = 0.50,
        ["G23"] = 0.60,
        ["M45A1"] = 0.50,
        ["G40"] = 0.80,
        ["KG-99"] = 0.50,
        ["G50"] = 1.00,
        ["FIVESEVEN"] = 1.20,
        ["ZIP22"] = 0.50,
        ["GIM1"] = 1.00,
        ["HARDBALLER"] = 0.80,
        ["IZHEVSKPB"] = 0.50,
        ["MAKAROVPM"] = 0.50,
        ["GB-22"] = 0.50,
        ["DESERTEAGLEXIX"] = 1.30,
        ["AUTOMAGIII"] = 1.20,
        ["GYROJETMARKI"] = 0.50,
        ["GSP"] = 0.10,
        ["GRIZZLY"] = 1.30,
        ["M2011"] = 0.50,
        ["ALIEN"] = 0.50,
        ["AF2011-A1"] = 0.50,
        ["G18C"] = 0.50,
        ["93R"] = 0.50,
        ["PP-2000"] = 1.00,
        ["TEC-9"] = 0.50,
        ["MICROUZI"] = 0.50,
        ["ŠKORPIONVZ.61"] = 0.50,
        ["ASMI"] = 0.50,
        ["MP1911"] = 0.50,
        ["ARMPISTOL"] = 0.90,
        ["MP412REX"] = 0.50,
        ["MATEBA6"] = 1.00,
        ["1858NEWARMY"] = 0.50,
        ["REDHAWK44"] = 1.00,
        ["JUDGE"] = 1.00,
        ["EXECUTIONER"] = 1.00,
        ["SUPERSHORTY"] = 0.60,
        ["SFG50"] = 10.00,
        ["M79THUMPER"] = 0.50,
        ["COILGUN"] = 0.50,
        ["SAWEDOFF"] = 0.60,
        ["SAIGA-12U"] = 0.40,
        ["OBREZ"] = 2.00,
        ["SASS308"] = 2.00,
        ["GLOCK17"] = 0.50
    },
    bullet_velocity = {
        ["AK12"] = 2950.00,
        ["REMINGTON700"] = 2650,
        ["AN-94"] = 2950.00,
        ["ASVAL"] = 1500.00,
        ["SCAR-L"] = 2300.00,
        ["AUGA1"] = 3200.00,
        ["M16A4"] = 2700.00,
        ["G36"] = 2700.00,
        ["M16A1"] = 3100.00,
        ["M16A3"] = 2700.00,
        ["TYPE20"] = 2625.00,
        ["AUGA2"] = 3200.00,
        ["K2"] = 2400.00,
        ["FAMASF1"] = 3100.00,
        ["AK47"] = 2350.00,
        ["AUGA3"] = 3200.00,
        ["L85A2"] = 2500.00,
        ["HK416"] = 2500.00,
        ["AK74"] = 2900.00,
        ["AKM"] = 2350.00,
        ["AK103"] = 2350.00,
        ["TAR-21"] = 2800.00,
        ["TYPE88"] = 2950.00,
        ["M231"] = 2200.00,
        ["C7A2"] = 2800.00,
        ["STG-44"] = 2250.00,
        ["G11K2"] = 3100.00,
        ["M14"] = 2550.00,
        ["BEOWULFECR"] = 1800.00,
        ["SCAR-H"] = 2900.00,
        ["AK12BR"] = 2700.00,
        ["G3A3"] = 2600.00,
        ["AG-3"] = 2600.00,
        ["HK417"] = 2500.00,
        ["HENRY45-70"] = 1800.00,
        ["FAL50.00"] = 2750.00,
        ["HCAR"] = 2500.00,
        ["M4A1"] = 2200.00,
        ["G36K"] = 2500.00,
        ["M4"] = 2200.00,
        ["L22"] = 2000.00,
        ["SCARPDW"] = 2200.00,
        ["AKU12"] = 2550.00,
        ["GROZA-1"] = 2400.00,
        ["OTS-126"] = 2300.00,
        ["AK12C"] = 2150.00,
        ["HONEYBADGER"] = 2000.00,
        ["K1A"] = 1700.00,
        ["SR-3M"] = 2000.00,
        ["GROZA-4"] = 1200.00,
        ["MC51"] = 2000.00,
        ["FAL50.63PARA"] = 2200.00,
        ["1858CARBINE"] = 1500.00,
        ["AK105"] = 2800.00,
        ["JURY"] = 1500.00,
        ["KACSRR"] = 1500.00,
        ["GYROJETCARBINE"] = 50.00,
        ["C8A2"] = 2400.00,
        ["X95R"] = 2200.00,
        ["HK51B"] = 2200.00,
        ["CANCANNON"] = 1000.00,
        ["KSG12"] = 1500.00,
        ["MODEL870"] = 1500.00,
        ["DBV12"] = 1500.00,
        ["KS-23M"] = 1500.00,
        ["SAIGA-12"] = 1500.00,
        ["STEVENSDB"] = 1600.00,
        ["E-GUN"] = 950.00,
        ["AA-12"] = 1500.00,
        ["SPAS-12"] = 1500.00,
        ["DT11"] = 2000.00,
        ["USAS-12"] = 1300.00,
        ["MP5K"] = 1200.00,
        ["UMP45"] = 870.00,
        ["G36C"] = 2300.00,
        ["MP7"] = 2400.00,
        ["MAC10"] = 920.00,
        ["P90"] = 2350.00,
        ["COLTMARS"] = 2600.00,
        ["MP5"] = 1300.00,
        ["COLTSMG633"] = 1300.00,
        ["L2A3"] = 1280.00,
        ["MP5SD"] = 1050.00,
        ["MP10"] = 1300.00,
        ["M3A1"] = 900.00,
        ["MP5/10"] = 1400.00,
        ["UZI"] = 1300.00,
        ["AUGA3PARAXS"] = 1200.00,
        ["K7"] = 1300.00,
        ["AKS74U"] = 2400.00,
        ["PPSH-41"] = 1600.00,
        ["FALPARASHORTY"] = 2000.00,
        ["KRISSVECTOR"] = 960.00,
        ["PP-19BIZON"] = 1250.00,
        ["MP40"] = 1310.00,
        ["X95SMG"] = 1300.00,
        ["TOMMYGUN"] = 935.00,
        ["RAMA1130"] = 1300.00,
        ["BWC9A"] = 1300.00,
        ["FIVE-0"] = 1200.00,
        ["MK11"] = 2800.00,
        ["SKS"] = 2500.00,
        ["SL-8"] = 2800.00,
        ["DRAGUNOVSVU"] = 2700.00,
        ["VSSVINTOREZ"] = 2000.00,
        ["MSG90"] = 2800.00,
        ["M21"] = 2650.00,
        ["BEOWULFTCR"] = 1800.00,
        ["SA58SPR"] = 2500.00,
        ["SCARSSR"] = 3000.00,
        ["COLTLMG"] = 2500.00,
        ["M60"] = 2800.00,
        ["AUGHBAR"] = 3300.00,
        ["MG36"] = 2700.00,
        ["RPK12"] = 3100.00,
        ["L86LSW"] = 3100.00,
        ["RPK"] = 2450.00,
        ["HK21E"] = 2600.00,
        ["HAMRIAR"] = 2600.00,
        ["RPK74"] = 3150.00,
        ["MG3KWS"] = 2700.00,
        ["M1918A2"] = 2800.00,
        ["MGV-176"] = 1550.00,
        ["STONER96"] = 3000.00,
        ["CHAINSAW"] = 3000.00,
        ["MG42"] = 2400.00,
        ["INTERVENTION"] = 3000.00,
        ["MODEL700"] = 2650.00,
        ["AWS"] = 2500.00,
        ["BFG50"] = 3000.00,
        ["AWM"] = 3000.00,
        ["TRG-42"] = 3000.00,
        ["MOSINNAGANT"] = 3000.00,
        ["DRAGUNOVSVDS"] = 2650.00,
        ["M1903"] = 3000.00,
        ["K14"] = 2800.00,
        ["HECATEII"] = 3000.00,
        ["FT300"] = 2800.00,
        ["M107"] = 2800.00,
        ["STEYRSCOUT"] = 3000.00,
        ["WA2000"] = 2850.00,
        ["NTW-20"] = 2400.00,
        ["M9"] = 1300.00,
        ["G17"] = 1230.00,
        ["M1911A1"] = 830.00,
        ["M17"] = 1200.00,
        ["DESERTEAGLEL5"] = 1700.00,
        ["G21"] = 810.00,
        ["G23"] = 1025.00,
        ["M45A1"] = 830.00,
        ["G40"] = 1350.00,
        ["KG-99"] = 1500.00,
        ["G50"] = 1250.00,
        ["FIVESEVEN"] = 2500.00,
        ["ZIP22"] = 1600.00,
        ["GIM1"] = 875.00,
        ["HARDBALLER"] = 1400.00,
        ["IZHEVSKPB"] = 950.00,
        ["MAKAROVPM"] = 1030.00,
        ["GB-22"] = 1900.00,
        ["DESERTEAGLEXIX"] = 1425.00,
        ["AUTOMAGIII"] = 1700.00,
        ["GYROJETMARKI"] = 25.00,
        ["GSP"] = 1800.00,
        ["GRIZZLY"] = 1500.00,
        ["M2011"] = 1300.00,
        ["ALIEN"] = 1300.00,
        ["AF2011-A1"] = 1250.00,
        ["G18C"] = 1230.00,
        ["93R"] = 1200.00,
        ["PP-2000"] = 2000.00,
        ["TEC-9"] = 1180.00,
        ["MICROUZI"] = 2000.00,
        ["ŠKORPIONVZ.61"] = 1200.00,
        ["ASMI"] = 1260.00,
        ["MP1911"] = 830.00,
        ["ARMPISTOL"] = 2300.00,
        ["MP412REX"] = 1700.00,
        ["MATEBA6"] = 1450.00,
        ["1858NEWARMY"] = 1000.00,
        ["REDHAWK44"] = 1600.00,
        ["JUDGE"] = 2000.00,
        ["EXECUTIONER"] = 2000.00,
        ["SUPERSHORTY"] = 1400.00,
        ["SFG50"] = 2000.00,
        ["M79THUMPER"] = 900.00,
        ["COILGUN"] = 950.00,
        ["SAWEDOFF"] = 1300.00,
        ["SAIGA-12U"] = 1400.00,
        ["OBREZ"] = 1500.00,
        ["SASS308"] = 3000.00,
        ["GLOCK17"] = 1230.00
    }
}
return gun_values
