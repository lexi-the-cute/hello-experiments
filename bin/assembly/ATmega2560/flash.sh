#!/bin/sh
avrdude -p atmega2560 -c USBasp -U flash:w:blink.hex
# avrdude -p m2560 -c USBasp -U flash:w:blink.hex
