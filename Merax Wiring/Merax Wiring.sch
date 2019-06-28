EESchema Schematic File Version 4
LIBS:Merax Wiring 2-cache
EELAYER 29 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 1
Title "Merax Bike Wiring"
Date "2019-06-27"
Rev ""
Comp "mHealth"
Comment1 "Kevin Zheng"
Comment2 "Electric Bike Project"
Comment3 ""
Comment4 "Merax Electric Mountain Bike wired to Cycle Analyst, ESP-32, and GPS unit"
$EndDescr
$Comp
L Merax_EBike_Parts:AUX_in J?
U 1 1 5D158611
P 9650 2350
F 0 "J?" H 9650 2550 50  0001 C CNN
F 1 "AUX_in" V 9000 2450 50  0001 R CNN
F 2 "" H 9650 2350 50  0001 C CNN
F 3 "~" H 9650 2350 50  0001 C CNN
	1    9650 2350
	0    -1   1    0   
$EndComp
Text Notes 9450 2300 1    50   ~ 0
red
Text Notes 10250 2300 1    50   ~ 0
yellow
Text Notes 9850 2300 1    50   ~ 0
white
$Comp
L Merax_EBike_Parts:Ebrake_Cutoff J?
U 1 1 5D12BC62
P 7850 2350
F 0 "J?" V 7696 2102 50  0001 R CNN
F 1 "Brake" H 7300 2450 50  0001 R CNN
F 2 "" H 7850 2350 50  0001 C CNN
F 3 "~" H 7850 2350 50  0001 C CNN
	1    7850 2350
	0    -1   1    0   
$EndComp
Text Notes 7650 2300 1    50   ~ 0
red
Text Notes 8150 2300 1    50   ~ 0
blue
$Comp
L Merax_EBike_Parts:Torque_PAS J?
U 1 1 5D130595
P 9050 2350
F 0 "J?" H 9050 2650 50  0001 C CNN
F 1 "Torque/PAS" V 8350 2550 50  0001 R CNN
F 2 "" H 9050 2350 50  0001 C CNN
F 3 "~" H 9050 2350 50  0001 C CNN
	1    9050 2350
	0    -1   1    0   
$EndComp
Text Notes 8750 2300 1    50   ~ 0
white
Text Notes 9350 2300 1    50   ~ 0
green
Text Notes 9950 2300 1    50   ~ 0
black
$Comp
L Merax_EBike_Parts:Thermistor J?
U 1 1 5D14F7DB
P 10050 2350
F 0 "J?" H 10050 2450 50  0001 C CNN
F 1 "Thermistor" H 9450 2350 50  0001 R CNN
F 2 "" H 10050 2350 50  0001 C CNN
F 3 "~" H 10050 2350 50  0001 C CNN
	1    10050 2350
	0    -1   1    0   
$EndComp
$Comp
L Merax_EBike_Parts:Cycle_Analyst U?
U 1 1 5D14DA50
P 9300 1300
F 0 "U?" H 8200 1900 50  0001 C CNN
F 1 "Cycle Analyst" H 7650 1900 60  0000 L CNN
F 2 "" H 9300 1300 50  0001 C CNN
F 3 "" H 9300 1300 50  0001 C CNN
	1    9300 1300
	1    0    0    -1  
$EndComp
$Comp
L Merax_EBike_Parts:CA-DP_Plug J?
U 1 1 5D132AF9
P 7150 1050
F 0 "J?" H 7150 1350 50  0001 C CNN
F 1 "CA-DP Plug" H 7150 1850 50  0001 R CNN
F 2 "" H 7150 1050 50  0001 C CNN
F 3 "~" H 7150 1050 50  0001 C CNN
	1    7150 1050
	-1   0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x05_Male J?
U 1 1 5D20ABA3
P 9050 2550
F 0 "J?" V 9158 2262 50  0001 R CNN
F 1 "Conn_01x05_Male" V 9113 2262 50  0001 R CNN
F 2 "" H 9050 2550 50  0001 C CNN
F 3 "~" H 9050 2550 50  0001 C CNN
	1    9050 2550
	0    -1   -1   0   
$EndComp
$Comp
L ESP32-footprints-Shem-Lib:ESP32-WROOM U?
U 1 1 5D1236DE
P 9300 5400
F 0 "U?" H 9275 6787 60  0001 C CNN
F 1 "ESP32-WROOM" H 8950 5400 60  0000 L CNN
F 2 "ESP32-footprints-Lib:ESP32-WROOM" H 9650 6750 60  0001 C CNN
F 3 "" H 8850 5850 60  0001 C CNN
	1    9300 5400
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x04_Male J?
U 1 1 5D244CC3
P 7850 2550
F 0 "J?" V 7958 2262 50  0001 R CNN
F 1 "Conn_01x04_Male" V 7913 2262 50  0001 R CNN
F 2 "" H 7850 2550 50  0001 C CNN
F 3 "~" H 7850 2550 50  0001 C CNN
	1    7850 2550
	0    -1   -1   0   
$EndComp
$Comp
L Connector:Conn_01x05_Female J?
U 1 1 5D146995
P 1950 2550
F 0 "J?" V 1842 2262 50  0001 R CNN
F 1 "Conn_01x05_Female" V 1797 2262 50  0001 R CNN
F 2 "" H 1950 2550 50  0001 C CNN
F 3 "~" H 1950 2550 50  0001 C CNN
	1    1950 2550
	0    -1   -1   0   
$EndComp
Text Notes 6750 6550 0    50   ~ 0
assist serial
Text Notes 6750 4100 0    50   ~ 0
cycle analyst serial
$Comp
L Connector:Conn_01x05_Male J?
U 1 1 5D14443E
P 1950 2350
F 0 "J?" V 2012 2062 50  0001 R CNN
F 1 "Conn_01x05_Male" V 2058 2062 50  0001 R CNN
F 2 "" H 1950 2350 50  0001 C CNN
F 3 "~" H 1950 2350 50  0001 C CNN
	1    1950 2350
	0    -1   1    0   
$EndComp
$Comp
L Merax_EBike_Parts:Pedal_To_Contr_F J?
U 1 1 5D16AF3B
P 3050 2550
F 0 "J?" V 2942 2362 50  0001 R CNN
F 1 "Pedal_To_Contr_F" V 2897 2362 50  0001 R CNN
F 2 "" H 3050 2550 50  0001 C CNN
F 3 "~" H 3050 2550 50  0001 C CNN
	1    3050 2550
	0    -1   -1   0   
$EndComp
$Comp
L Merax_EBike_Parts:Pedal_To_Cont_M J?
U 1 1 5D164757
P 3050 2350
F 0 "J?" V 3112 2162 50  0001 R CNN
F 1 "Pedals" V 2450 2450 50  0001 R CNN
F 2 "" H 3050 2350 50  0001 C CNN
F 3 "~" H 3050 2350 50  0001 C CNN
	1    3050 2350
	0    -1   1    0   
$EndComp
Wire Wire Line
	2150 7050 2150 7300
Wire Wire Line
	2050 7050 2050 7300
Wire Wire Line
	1950 7050 1950 7300
Wire Wire Line
	1850 7050 1850 7300
Wire Wire Line
	1750 7050 1750 7300
$Comp
L Connector:Conn_01x05_Male J?
U 1 1 5D147C6E
P 1950 6650
F 0 "J?" V 2012 6362 50  0001 R CNN
F 1 "Conn_01x05_Male" V 2058 6362 50  0001 R CNN
F 2 "" H 1950 6650 50  0001 C CNN
F 3 "~" H 1950 6650 50  0001 C CNN
	1    1950 6650
	0    -1   1    0   
$EndComp
$Comp
L Connector:Conn_01x05_Female J?
U 1 1 5D14AEA0
P 1950 6850
F 0 "J?" V 1888 6562 50  0001 R CNN
F 1 "Conn_01x05_Female" V 1842 6562 50  0001 R CNN
F 2 "" H 1950 6850 50  0001 C CNN
F 3 "~" H 1950 6850 50  0001 C CNN
	1    1950 6850
	0    -1   -1   0   
$EndComp
$Comp
L Connector:Conn_01x02_Male J?
U 1 1 5D6DB076
P 850 7050
F 0 "J?" V 1004 6862 50  0001 R CNN
F 1 "Conn_01x02_Male" V 958 6862 50  0001 R CNN
F 2 "" H 850 7050 50  0001 C CNN
F 3 "~" H 850 7050 50  0001 C CNN
	1    850  7050
	0    -1   -1   0   
$EndComp
$Comp
L Connector:Conn_01x02_Male J?
U 1 1 5D6DCF82
P 3250 7050
F 0 "J?" V 3404 6862 50  0001 R CNN
F 1 "Conn_01x02_Male" V 3358 6862 50  0001 R CNN
F 2 "" H 3250 7050 50  0001 C CNN
F 3 "~" H 3250 7050 50  0001 C CNN
	1    3250 7050
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3250 7300 3250 6850
Wire Wire Line
	3350 7300 3350 6850
$Comp
L Connector:Conn_01x02_Female J?
U 1 1 5D6F5A1C
P 850 6850
F 0 "J?" V 696 6662 50  0001 R CNN
F 1 "Conn_01x02_Female" V 742 6662 50  0001 R CNN
F 2 "" H 850 6850 50  0001 C CNN
F 3 "~" H 850 6850 50  0001 C CNN
	1    850  6850
	0    -1   1    0   
$EndComp
$Comp
L Connector:Conn_01x02_Female J?
U 1 1 5D6F7ABC
P 3250 6850
F 0 "J?" V 3096 6662 50  0001 R CNN
F 1 "Conn_01x02_Female" V 3142 6662 50  0001 R CNN
F 2 "" H 3250 6850 50  0001 C CNN
F 3 "~" H 3250 6850 50  0001 C CNN
	1    3250 6850
	0    -1   1    0   
$EndComp
$Comp
L Connector:Conn_01x02_Female J?
U 1 1 5D7FED0F
P 850 2550
F 0 "J?" V 742 2362 50  0001 R CNN
F 1 "Conn_01x02_Female" V 787 2598 50  0001 L CNN
F 2 "" H 850 2550 50  0001 C CNN
F 3 "~" H 850 2550 50  0001 C CNN
	1    850  2550
	0    -1   1    0   
$EndComp
$Comp
L Connector:Conn_01x02_Male J?
U 1 1 5D8282BD
P 850 2750
F 0 "J?" V 958 2562 50  0001 R CNN
F 1 "Conn_01x02_Male" V 913 2562 50  0001 R CNN
F 2 "" H 850 2750 50  0001 C CNN
F 3 "~" H 850 2750 50  0001 C CNN
	1    850  2750
	0    -1   -1   0   
$EndComp
Wire Notes Line
	2900 2300 3200 2300
Wire Notes Line
	3200 2300 3200 2800
Wire Notes Line
	3200 2800 2900 2800
Wire Notes Line
	2900 2800 2900 2300
Wire Notes Line
	1700 2300 2200 2300
Wire Notes Line
	2200 2300 2200 2800
Wire Notes Line
	2200 2800 1700 2800
Wire Notes Line
	1700 2800 1700 2300
Wire Notes Line
	800  2300 1000 2300
Wire Notes Line
	1000 2300 1000 2800
Wire Notes Line
	1000 2800 800  2800
Wire Notes Line
	800  2800 800  2300
Wire Notes Line
	3600 2300 4200 2300
Wire Notes Line
	8300 2600 8600 2600
Wire Notes Line
	8600 2150 8300 2150
Wire Notes Line
	8800 2600 9300 2600
Wire Notes Line
	9300 2600 9300 2150
Wire Notes Line
	9300 2150 8800 2150
Wire Notes Line
	8800 2150 8800 2600
Wire Notes Line
	7700 2600 7700 2150
Wire Notes Line
	7700 2150 8100 2150
Wire Notes Line
	8100 2150 8100 2600
Wire Notes Line
	8100 2600 7700 2600
Wire Notes Line
	7200 800  7200 1400
Wire Notes Line
	7200 1400 6700 1400
Wire Notes Line
	6700 1400 6700 800 
Wire Notes Line
	4000 6600 3700 6600
Wire Notes Line
	1700 6600 2200 6600
Wire Notes Line
	2200 6600 2200 7100
Wire Notes Line
	2200 7100 1700 7100
Wire Notes Line
	1700 7100 1700 6600
Wire Notes Line
	800  6600 1000 6600
Wire Notes Line
	1000 6600 1000 7100
Wire Notes Line
	1000 7100 800  7100
Wire Notes Line
	800  7100 800  6600
Wire Notes Line
	3200 6600 3200 7100
Wire Notes Line
	3200 7100 3400 7100
Wire Notes Line
	3400 7100 3400 6600
Wire Notes Line
	3400 6600 3200 6600
Wire Wire Line
	2150 2750 2150 5900
Wire Notes Line
	6850 1800 7150 1800
Text Notes 7750 4800 0    50   ~ 0
5V power
$Comp
L Merax_EBike_Parts:handlebar_complete U?
U 1 1 5E64E060
P 2000 7750
F 0 "U?" H 1550 8800 50  0001 C CNN
F 1 "handlebar_complete" H 1300 8900 50  0001 C CNN
F 2 "" H 1000 7750 50  0001 C CNN
F 3 "" H 1000 7750 50  0001 C CNN
	1    2000 7750
	1    0    0    -1  
$EndComp
$Comp
L Merax_EBike_Parts:Motor U?
U 1 1 5D15012D
P 4950 8100
F 0 "U?" H 5550 9450 50  0001 C CNN
F 1 "Motor" H 4200 8400 50  0000 L CNN
F 2 "" H 4950 8100 50  0001 C CNN
F 3 "" H 4950 8100 50  0001 C CNN
	1    4950 8100
	1    0    0    -1  
$EndComp
Wire Wire Line
	4650 7300 4650 6850
Wire Wire Line
	4550 7300 4550 6850
Wire Wire Line
	4850 7300 4850 6850
Wire Wire Line
	4950 7300 4950 6850
Wire Wire Line
	4750 7300 4750 6850
Wire Wire Line
	4450 7300 4450 6850
$Comp
L Merax_EBike_Parts:Motor_Wires_M J?
U 1 1 5D186A62
P 3850 2750
F 0 "J?" H 3850 3050 50  0001 C CNN
F 1 "Motor_Wires_M" V 3958 2406 50  0001 R CNN
F 2 "" H 3850 2750 50  0001 C CNN
F 3 "~" H 3850 2750 50  0001 C CNN
	1    3850 2750
	0    -1   -1   0   
$EndComp
Wire Notes Line
	4400 7100 4400 6600
Wire Notes Line
	5000 7100 4400 7100
Wire Notes Line
	5000 6600 5000 7100
Wire Notes Line
	4400 6600 5000 6600
$Comp
L Merax_EBike_Parts:Motor_Wires_M J?
U 1 1 5D17E7E2
P 4650 7050
F 0 "J?" H 4650 7350 50  0001 C CNN
F 1 "Motor" V 4758 6706 50  0001 R CNN
F 2 "" H 4650 7050 50  0001 C CNN
F 3 "~" H 4650 7050 50  0001 C CNN
	1    4650 7050
	0    -1   -1   0   
$EndComp
$Comp
L Merax_EBike_Parts:Motor_Wires_F J?
U 1 1 5D181A4A
P 4650 6850
F 0 "J?" H 4650 7150 50  0001 C CNN
F 1 "Motor_Wires_F" V 4542 6502 50  0001 R CNN
F 2 "" H 4650 6850 50  0001 C CNN
F 3 "~" H 4650 6850 50  0001 C CNN
	1    4650 6850
	0    -1   1    0   
$EndComp
Wire Notes Line
	3600 2800 3600 2300
Wire Notes Line
	4200 2800 3600 2800
Wire Notes Line
	4200 2300 4200 2800
$Comp
L Merax_EBike_Parts:Motor_Wires_F J?
U 1 1 5D184078
P 3850 2550
F 0 "J?" H 3850 2850 50  0001 C CNN
F 1 "Motor" V 3000 2600 50  0001 R CNN
F 2 "" H 3850 2550 50  0001 C CNN
F 3 "~" H 3850 2550 50  0001 C CNN
	1    3850 2550
	0    -1   1    0   
$EndComp
Wire Wire Line
	1750 2250 1750 2550
Wire Wire Line
	1850 2250 1850 2550
Wire Wire Line
	1950 2250 1950 2550
Wire Wire Line
	2050 2250 2050 2550
Wire Wire Line
	2150 2250 2150 2550
Wire Wire Line
	1850 2750 1850 5200
Wire Wire Line
	1950 2750 1950 5250
Wire Notes Line
	1200 7100 1200 6600
Wire Notes Line
	1500 7100 1200 7100
Wire Notes Line
	1500 6600 1500 7100
Wire Notes Line
	1200 6600 1500 6600
Wire Notes Line
	1200 2800 1200 2300
Wire Notes Line
	1500 2800 1200 2800
Wire Notes Line
	1500 2300 1500 2800
Wire Notes Line
	1200 2300 1500 2300
$Comp
L Connector:Conn_01x03_Female J?
U 1 1 5D45542F
P 1350 6850
F 0 "J?" V 1242 6662 50  0001 R CNN
F 1 "Conn_01x03_Female" V 1287 6662 50  0001 R CNN
F 2 "" H 1350 6850 50  0001 C CNN
F 3 "~" H 1350 6850 50  0001 C CNN
	1    1350 6850
	0    -1   1    0   
$EndComp
$Comp
L Connector:Conn_01x03_Male J?
U 1 1 5D455435
P 1350 7050
F 0 "J?" V 1458 6862 50  0001 R CNN
F 1 "Conn_01x03_Male" V 1413 6862 50  0001 R CNN
F 2 "" H 1350 7050 50  0001 C CNN
F 3 "~" H 1350 7050 50  0001 C CNN
	1    1350 7050
	0    -1   -1   0   
$EndComp
$Comp
L Connector:Conn_01x03_Male J?
U 1 1 5D4122AB
P 1350 2750
F 0 "J?" V 1458 2562 50  0001 R CNN
F 1 "Conn_01x03_Male" V 1413 2562 50  0001 R CNN
F 2 "" H 1350 2750 50  0001 C CNN
F 3 "~" H 1350 2750 50  0001 C CNN
	1    1350 2750
	0    -1   -1   0   
$EndComp
$Comp
L Connector:Conn_01x03_Female J?
U 1 1 5D41107C
P 1350 2550
F 0 "J?" V 1242 2362 50  0001 R CNN
F 1 "Conn_01x03_Female" V 1287 2362 50  0001 R CNN
F 2 "" H 1350 2550 50  0001 C CNN
F 3 "~" H 1350 2550 50  0001 C CNN
	1    1350 2550
	0    -1   1    0   
$EndComp
Wire Wire Line
	1250 2250 1250 2350
Wire Wire Line
	1350 2250 1350 2350
Wire Wire Line
	1450 2250 1450 2350
Wire Wire Line
	1250 6850 1250 7300
Wire Wire Line
	1350 6850 1350 7300
Wire Wire Line
	1450 6850 1450 7300
Wire Wire Line
	950  2550 950  6150
Wire Wire Line
	850  2550 850  5550
Connection ~ 850  5550
Wire Wire Line
	850  5550 850  6200
Wire Wire Line
	950  6850 950  7300
Wire Wire Line
	850  6850 850  7300
Wire Wire Line
	850  2250 850  2350
Wire Wire Line
	950  2250 950  2350
Wire Wire Line
	3250 6200 850  6200
Wire Wire Line
	3350 6150 950  6150
Wire Notes Line
	2700 6600 2400 6600
Wire Notes Line
	2700 7100 2700 6600
Wire Notes Line
	2400 7100 2700 7100
Wire Notes Line
	2400 6600 2400 7100
Wire Wire Line
	2650 7300 2650 7050
Wire Wire Line
	2550 7300 2550 7050
Wire Wire Line
	2450 7300 2450 7050
$Comp
L Connector:Conn_01x03_Female J?
U 1 1 5D47653C
P 2550 6850
F 0 "J?" V 2442 6662 50  0001 R CNN
F 1 "Conn_01x03_Female" V 2487 6662 50  0001 R CNN
F 2 "" H 2550 6850 50  0001 C CNN
F 3 "~" H 2550 6850 50  0001 C CNN
	1    2550 6850
	0    -1   -1   0   
$EndComp
$Comp
L Connector:Conn_01x02_Female J?
U 1 1 5D45097F
P 2850 6850
F 0 "J?" H 2878 6780 50  0001 L CNN
F 1 "Conn_01x02_Female" H 2878 6735 50  0001 L CNN
F 2 "" H 2850 6850 50  0001 C CNN
F 3 "~" H 2850 6850 50  0001 C CNN
	1    2850 6850
	0    -1   1    0   
$EndComp
$Comp
L Connector:Conn_01x02_Male J?
U 1 1 5D450985
P 2850 7050
F 0 "J?" H 2822 7024 50  0001 R CNN
F 1 "Conn_01x02_Male" H 2822 6978 50  0001 R CNN
F 2 "" H 2850 7050 50  0001 C CNN
F 3 "~" H 2850 7050 50  0001 C CNN
	1    2850 7050
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2850 7300 2850 6850
Wire Wire Line
	2950 7300 2950 6850
Wire Notes Line
	2800 6600 3000 6600
Wire Notes Line
	3000 6600 3000 7100
Wire Notes Line
	3000 7100 2800 7100
Wire Notes Line
	2800 7100 2800 6600
Wire Wire Line
	2650 6400 2950 6400
$Comp
L Connector:Conn_01x03_Male J?
U 1 1 5D476536
P 2550 6650
F 0 "J?" V 2658 6462 50  0001 R CNN
F 1 "Conn_01x03_Male" V 2613 6462 50  0001 R CNN
F 2 "" H 2550 6650 50  0001 C CNN
F 3 "~" H 2550 6650 50  0001 C CNN
	1    2550 6650
	0    -1   1    0   
$EndComp
Wire Wire Line
	2650 2250 2650 6350
Wire Wire Line
	2650 6350 2850 6350
Connection ~ 850  6200
Wire Wire Line
	850  6200 850  6650
Wire Wire Line
	950  6150 950  6650
Connection ~ 950  6150
Wire Wire Line
	1350 2550 1350 6650
Wire Wire Line
	1450 2550 1450 6650
Wire Wire Line
	1750 2750 1750 6850
Wire Wire Line
	1850 5200 1850 6850
Connection ~ 1850 5200
Wire Wire Line
	1950 5250 1950 6850
Connection ~ 1950 5250
Wire Wire Line
	2050 2750 2050 6850
Wire Wire Line
	2150 5900 2150 6850
Connection ~ 2150 5900
Wire Wire Line
	2450 2250 2450 6850
Wire Wire Line
	2550 2250 2550 6850
Wire Wire Line
	2950 6400 2950 6650
Wire Wire Line
	2650 6400 2650 6850
Wire Wire Line
	2850 6350 2850 6650
Wire Wire Line
	3250 6200 3250 6650
Wire Wire Line
	3350 6150 3350 6650
$Comp
L Merax_EBike_Parts:Pedal_Sensor U?
U 1 1 5D14BB93
P 4150 7750
F 0 "U?" H 4150 7750 50  0001 C CNN
F 1 "Pedals" V 4100 7250 50  0000 L CNN
F 2 "" H 4150 7750 50  0001 C CNN
F 3 "" H 4150 7750 50  0001 C CNN
	1    4150 7750
	0    1    -1   0   
$EndComp
Wire Wire Line
	3950 7050 3950 7300
Wire Wire Line
	3750 7050 3750 7300
Wire Wire Line
	3850 7050 3850 7300
Wire Notes Line
	4000 7100 4000 6600
Wire Notes Line
	3700 7100 4000 7100
Wire Notes Line
	3700 6600 3700 7100
$Comp
L Merax_EBike_Parts:From_Pedal_F J?
U 1 1 5D157E59
P 3850 6850
F 0 "J?" H 3850 7050 50  0001 C CNN
F 1 "From_Pedal_F" H 3850 6650 50  0001 C CNN
F 2 "" H 3850 6850 50  0001 C CNN
F 3 "~" H 3850 6850 50  0001 C CNN
	1    3850 6850
	0    -1   -1   0   
$EndComp
$Comp
L Merax_EBike_Parts:From_Pedal_M J?
U 1 1 5D161A7F
P 3850 6650
F 0 "J?" H 3822 6628 50  0001 R CNN
F 1 "From_Pedal_M" H 3822 6583 50  0001 R CNN
F 2 "" H 3850 6650 50  0001 C CNN
F 3 "~" H 3850 6650 50  0001 C CNN
	1    3850 6650
	0    -1   1    0   
$EndComp
Wire Wire Line
	1850 5200 6350 5200
Wire Wire Line
	1950 5250 6400 5250
Wire Wire Line
	2950 2250 2950 2550
Wire Wire Line
	3050 2250 3050 2550
Wire Wire Line
	3150 2250 3150 2550
Wire Wire Line
	3650 2250 3650 2350
Wire Wire Line
	3750 2250 3750 2350
Wire Wire Line
	3850 2250 3850 2350
Wire Wire Line
	3950 2250 3950 2350
Wire Wire Line
	4050 2250 4050 2350
Wire Wire Line
	4150 2250 4150 2350
Wire Notes Line
	8300 2150 8300 2600
Wire Notes Line
	8600 2600 8600 2150
$Comp
L Merax_EBike_Parts:Throttle_Input J?
U 1 1 5D129243
P 8450 2350
F 0 "J?" H 8450 2550 50  0001 C CNN
F 1 "Throttle" V 7600 2400 50  0001 R CNN
F 2 "" H 8450 2350 50  0001 C CNN
F 3 "~" H 8450 2350 50  0001 C CNN
	1    8450 2350
	0    -1   1    0   
$EndComp
$Comp
L Connector:Conn_01x03_Male J?
U 1 1 5D241186
P 8450 2550
F 0 "J?" H 8558 2739 50  0001 C CNN
F 1 "Conn_01x03_Male" H 8558 2740 50  0001 C CNN
F 2 "" H 8450 2550 50  0001 C CNN
F 3 "~" H 8450 2550 50  0001 C CNN
	1    8450 2550
	0    -1   -1   0   
$EndComp
Text Notes 8650 2300 1    50   ~ 0
green
Text Notes 8250 2300 1    50   ~ 0
red
Wire Wire Line
	8050 2700 8050 2350
Wire Wire Line
	8550 2800 8550 2350
Wire Wire Line
	1250 5600 1250 6650
Wire Wire Line
	1250 2550 1250 5600
Connection ~ 1250 5600
Wire Notes Line
	6850 2100 6850 1800
Wire Notes Line
	7150 2100 6850 2100
Wire Notes Line
	7150 1800 7150 2100
$Comp
L Merax_EBike_Parts:Com_Cable J?
U 1 1 5D14797C
P 6900 1950
F 0 "J?" V 6746 1802 50  0001 R CNN
F 1 "Com_Cable" H 5700 2250 50  0001 R CNN
F 2 "" H 6900 1950 50  0001 C CNN
F 3 "~" H 6900 1950 50  0001 C CNN
	1    6900 1950
	-1   0    0    -1  
$EndComp
Wire Wire Line
	7400 1600 7500 1600
Wire Wire Line
	7350 1500 7500 1500
Wire Notes Line
	6700 800  7200 800 
$Comp
L Connector:Conn_01x06_Female J?
U 1 1 5D18A80B
P 6950 1050
F 0 "J?" H 6978 1026 50  0001 L CNN
F 1 "Conn_01x06_Female" H 6978 980 50  0001 L CNN
F 2 "" H 6950 1050 50  0001 C CNN
F 3 "~" H 6950 1050 50  0001 C CNN
	1    6950 1050
	1    0    0    -1  
$EndComp
Wire Wire Line
	7500 850  6950 850 
Wire Wire Line
	7500 900  7250 900 
Wire Wire Line
	7250 900  7250 950 
Wire Wire Line
	6950 950  7250 950 
Wire Wire Line
	7300 950  7500 950 
Wire Wire Line
	6950 1050 7300 1050
Wire Wire Line
	7300 1050 7300 950 
Wire Wire Line
	7350 1150 7350 1000
Wire Wire Line
	7350 1000 7500 1000
Wire Wire Line
	6950 1150 7350 1150
Wire Wire Line
	7500 1050 7400 1050
Wire Wire Line
	7400 1050 7400 1250
Wire Wire Line
	6950 1250 7400 1250
Wire Wire Line
	7450 1350 7450 1100
Wire Wire Line
	7450 1100 7500 1100
Wire Wire Line
	6950 1350 7450 1350
Wire Wire Line
	6550 2550 6550 5550
Wire Wire Line
	850  5550 6550 5550
Wire Wire Line
	1250 5600 6600 5600
Wire Wire Line
	7400 2900 7700 2900
Wire Wire Line
	7400 3050 7400 2900
Wire Wire Line
	7300 2800 7700 2800
Wire Wire Line
	7400 2700 7700 2700
Wire Wire Line
	7400 2550 7400 2700
$Comp
L Connector:Conn_01x02_Female J?
U 1 1 5D2E35BE
P 7100 3050
F 0 "J?" H 7128 2980 50  0001 L CNN
F 1 "Conn_01x02_Female" H 7128 2935 50  0001 L CNN
F 2 "" H 7100 3050 50  0001 C CNN
F 3 "~" H 7100 3050 50  0001 C CNN
	1    7100 3050
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male J?
U 1 1 5D2E589B
P 7300 3050
F 0 "J?" H 7272 3024 50  0001 R CNN
F 1 "Conn_01x02_Male" H 7272 2978 50  0001 R CNN
F 2 "" H 7300 3050 50  0001 C CNN
F 3 "~" H 7300 3050 50  0001 C CNN
	1    7300 3050
	-1   0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male J?
U 1 1 5D2E7419
P 7300 2800
F 0 "J?" H 7272 2774 50  0001 R CNN
F 1 "Conn_01x02_Male" H 7272 2728 50  0001 R CNN
F 2 "" H 7300 2800 50  0001 C CNN
F 3 "~" H 7300 2800 50  0001 C CNN
	1    7300 2800
	-1   0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male J?
U 1 1 5D2F1170
P 7300 2550
F 0 "J?" H 7272 2524 50  0001 R CNN
F 1 "Conn_01x02_Male" H 7272 2478 50  0001 R CNN
F 2 "" H 7300 2550 50  0001 C CNN
F 3 "~" H 7300 2550 50  0001 C CNN
	1    7300 2550
	-1   0    0    -1  
$EndComp
Wire Wire Line
	7100 2550 7400 2550
Wire Wire Line
	7400 3050 7100 3050
Wire Notes Line
	6850 2500 6850 2700
Wire Notes Line
	6850 2700 7350 2700
Wire Notes Line
	7350 2700 7350 2500
Wire Notes Line
	7350 2500 6850 2500
Wire Notes Line
	6850 2750 7350 2750
Wire Notes Line
	7350 2750 7350 2950
Wire Notes Line
	7350 2950 6850 2950
Wire Notes Line
	6850 2950 6850 2750
Wire Notes Line
	6850 3000 7350 3000
Wire Notes Line
	7350 3000 7350 3200
Wire Notes Line
	7350 3200 6850 3200
Wire Notes Line
	6850 3200 6850 3000
$Comp
L Connector:Conn_01x02_Female J?
U 1 1 5D2F1166
P 7100 2550
F 0 "J?" H 7128 2480 50  0001 L CNN
F 1 "Conn_01x02_Female" H 7128 2435 50  0001 L CNN
F 2 "" H 7100 2550 50  0001 C CNN
F 3 "~" H 7100 2550 50  0001 C CNN
	1    7100 2550
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Female J?
U 1 1 5D2E740F
P 7100 2800
F 0 "J?" H 7128 2730 50  0001 L CNN
F 1 "Conn_01x02_Female" H 7128 2685 50  0001 L CNN
F 2 "" H 7100 2800 50  0001 C CNN
F 3 "~" H 7100 2800 50  0001 C CNN
	1    7100 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	7900 2800 8550 2800
Wire Wire Line
	7900 2700 8050 2700
$Comp
L Merax_EBike_Parts:redgrblk_f J?
U 1 1 5D19F46B
P 7700 2800
F 0 "J?" H 7700 3000 50  0001 C CNN
F 1 "redgrblk_f" V 7592 2652 50  0001 R CNN
F 2 "" H 7700 2800 50  0001 C CNN
F 3 "~" H 7700 2800 50  0001 C CNN
	1    7700 2800
	-1   0    0    1   
$EndComp
$Comp
L Merax_EBike_Parts:redgrblk_m J?
U 1 1 5D19847F
P 7500 2800
F 0 "J?" V 7536 2988 50  0001 L CNN
F 1 "redgrblk_m" V 7582 2656 50  0001 R CNN
F 2 "" H 7500 2800 50  0001 C CNN
F 3 "~" H 7500 2800 50  0001 C CNN
	1    7500 2800
	1    0    0    1   
$EndComp
Wire Notes Line
	7450 2650 7950 2650
Wire Notes Line
	7950 2650 7950 2950
Wire Notes Line
	7950 2950 7450 2950
Wire Notes Line
	7450 2650 7450 2950
Wire Wire Line
	7900 2900 9150 2900
Wire Wire Line
	9150 2900 9150 2350
Wire Wire Line
	6650 3050 6900 3050
Wire Wire Line
	6600 2800 6900 2800
Wire Wire Line
	6550 2550 6900 2550
Wire Wire Line
	7350 1500 7350 1850
Wire Wire Line
	7450 1700 7500 1700
Wire Wire Line
	6750 1950 6750 4100
Wire Wire Line
	6350 850  6750 850 
Wire Wire Line
	6400 950  6750 950 
Wire Wire Line
	6450 1250 6750 1250
Wire Wire Line
	6650 3050 6650 5650
Wire Wire Line
	6600 2800 6600 5600
Wire Wire Line
	6350 850  6350 5200
Wire Wire Line
	6400 950  6400 5250
$Comp
L Device:Battery BT?
U 1 1 5E567D54
P 6100 3600
F 0 "BT?" V 5855 3600 50  0001 C CNN
F 1 "Battery" V 6200 3600 50  0001 C CNN
F 2 "" V 6100 3660 50  0001 C CNN
F 3 "~" V 6100 3660 50  0001 C CNN
	1    6100 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4250 7300 4250 4600
Wire Wire Line
	3950 6850 3950 5650
Wire Wire Line
	3750 6850 3750 4950
Wire Wire Line
	3950 5650 6650 5650
Connection ~ 3950 5650
Wire Wire Line
	3950 5650 3950 4850
Wire Wire Line
	4450 6650 4450 4450
Wire Wire Line
	4650 6650 4650 4350
Wire Wire Line
	4850 6650 4850 4250
Wire Wire Line
	6450 5300 4950 5300
Connection ~ 4950 5300
Wire Wire Line
	4950 5300 4950 6650
Wire Wire Line
	7450 1700 7450 2050
Wire Wire Line
	7100 2050 7450 2050
Wire Wire Line
	7350 1850 7100 1850
Wire Wire Line
	7100 1950 7400 1950
Wire Wire Line
	7400 1950 7400 1600
Wire Wire Line
	6750 1950 6900 1950
Wire Wire Line
	3750 4950 2950 4950
Wire Wire Line
	3050 4900 3850 4900
Wire Wire Line
	3850 4900 3850 6850
Wire Wire Line
	3950 4850 3150 4850
Wire Wire Line
	3450 4600 4250 4600
Wire Wire Line
	4300 4550 3500 4550
Wire Wire Line
	4300 4550 4300 7300
Wire Wire Line
	3550 4500 4350 4500
Wire Wire Line
	4350 4500 4350 7300
Wire Wire Line
	4450 4450 3650 4450
Wire Wire Line
	3750 4400 4550 4400
Wire Wire Line
	4550 4400 4550 6650
Wire Wire Line
	4650 4350 3850 4350
Wire Wire Line
	3950 4300 4750 4300
Wire Wire Line
	4750 4300 4750 6650
Wire Wire Line
	4050 4250 4850 4250
Wire Wire Line
	4950 4200 4950 5300
Wire Wire Line
	4150 2550 4150 4200
Wire Wire Line
	4050 2550 4050 4250
Wire Wire Line
	3950 2550 3950 4300
Wire Wire Line
	3850 2550 3850 4350
Wire Wire Line
	3750 2550 3750 4400
Wire Wire Line
	3650 2550 3650 4450
Wire Wire Line
	2950 2750 2950 4950
Wire Wire Line
	3050 2750 3050 4900
Wire Wire Line
	3150 2750 3150 4850
Wire Wire Line
	3450 2250 3450 4600
Wire Wire Line
	3500 2250 3500 4550
Wire Wire Line
	3550 2250 3550 4500
$Comp
L Merax_EBike_Parts:Motor_Controller U?
U 1 1 5D1499F4
P 1300 1000
F 0 "U?" H 1300 1000 50  0001 C CNN
F 1 "Motor Controller" H 750 1300 60  0000 L CNN
F 2 "" H 1300 1000 50  0001 C CNN
F 3 "" H 1300 1000 50  0001 C CNN
	1    1300 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 1250 6450 5300
Wire Wire Line
	10400 4100 10400 4850
Wire Wire Line
	10400 4850 10200 4850
Wire Wire Line
	10400 6550 10400 5550
Wire Wire Line
	10400 5550 10200 5550
Wire Wire Line
	2150 5900 6750 5900
Wire Wire Line
	6750 4100 10400 4100
Wire Wire Line
	4150 4200 4950 4200
Wire Wire Line
	6800 6100 8350 6100
Wire Wire Line
	6750 5900 6750 6550
Wire Wire Line
	6750 6550 10400 6550
Wire Wire Line
	6250 4800 8100 4800
Wire Wire Line
	5250 4600 5200 4600
Wire Wire Line
	6800 5050 6800 6100
$Comp
L Regulator_Switching:LM2596S-5 U?
U 1 1 5E511D22
P 5750 4700
F 0 "U?" H 5750 5067 50  0001 C CNN
F 1 "LM2596S-5" H 5550 4750 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:TO-263-5_TabPin3" H 5800 4450 50  0001 L CIN
F 3 "http://www.ti.com/lit/ds/symlink/lm2596.pdf" H 5750 4700 50  0001 C CNN
	1    5750 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	5750 5000 5750 5050
Connection ~ 5750 5050
Wire Wire Line
	5750 5050 6800 5050
Wire Wire Line
	4400 3900 4400 3350
Wire Wire Line
	4400 950  4350 950 
Wire Wire Line
	6250 850  6250 3350
Wire Wire Line
	6250 850  4350 850 
Wire Wire Line
	5150 5050 5750 5050
$Comp
L Merax_EBike_Parts:GPS U?
U 1 1 601FA0C7
P 5150 3200
F 0 "U?" H 5150 3200 50  0001 C CNN
F 1 "GPS" H 5250 3200 50  0000 L CNN
F 2 "" H 5150 3200 50  0001 C CNN
F 3 "" H 5150 3200 50  0001 C CNN
	1    5150 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5850 3350 6100 3350
Connection ~ 6250 3350
Wire Wire Line
	4800 3350 4400 3350
Connection ~ 4400 3350
Wire Wire Line
	4400 3350 4400 950 
Connection ~ 6100 3350
Wire Wire Line
	6100 3350 6250 3350
Wire Wire Line
	6100 3350 6100 3400
Wire Wire Line
	6100 3800 6100 3900
Wire Wire Line
	4400 3900 5150 3900
Wire Wire Line
	5150 3900 5150 5050
Connection ~ 5150 3900
Wire Wire Line
	5150 3900 6100 3900
Wire Wire Line
	5200 3950 6250 3950
Wire Wire Line
	5200 3950 5200 4600
Wire Wire Line
	6250 3350 6250 3950
$EndSCHEMATC
