# Temperature recorder

## Installation WSGI

Cloner le projet
```bash
git clone https://github.com/Gaspi/rasp-temperature-record.git
cd rasp-temperature-record
```

Configurer les chemins d'installation du fichier `Makefile` puis installer:
```bash
sudo make Q=
```

## Setup BME x Raspberry

To identify the Raspberry pins: `pinout`
```
J8:
   3V3  (1) (2)  5V
 GPIO2  (3) (4)  5V
 GPIO3  (5) (6)  GND
 GPIO4  (7) (8)  GPIO14
   GND  (9) (10) GPIO15
GPIO17 (11) (12) GPIO18
GPIO27 (13) (14) GND
GPIO22 (15) (16) GPIO23
   3V3 (17) (18) GPIO24
GPIO10 (19) (20) GND
 GPIO9 (21) (22) GPIO25
GPIO11 (23) (24) GPIO8
   GND (25) (26) GPIO7
 GPIO0 (27) (28) GPIO1
 GPIO5 (29) (30) GND
 GPIO6 (31) (32) GPIO12
GPIO13 (33) (34) GND
GPIO19 (35) (36) GPIO16
GPIO26 (37) (38) GPIO20
   GND (39) (40) GPIO21
```

The BME  has 6 pins
```
VIN
GND
SDA
SCL
CSB
SDO
```

Correct wiring for I²C (6-pin version)

| BME280 Pin | Raspberry Pi Pin    | Purpose                     |
|------------|---------------------|-----------------------------|
| VIN        | 3.3V (Pin 1)        | Power                       |
| GND        | GND (Pin 6)         | Ground                      |
| SDA        | Pin 3 (GPIO2)       | I2C SDA                     |
| SCL        | Pin 5 (GPIO3)       | I2C SCL                     |
| CSB        | 3.3V (Pin 17)       | Forces I²C mode             |
| SDO        | GND (Pin 9) or 3.3V | Sets address (0x76 or 0x77) |

To check: `i2cdetect -y 1` should display
```
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- 76 --
```
