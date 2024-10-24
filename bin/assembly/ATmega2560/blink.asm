; This program blinks the Arduino Atmega2560's internal LED on/off every second
; NOTE: The delay count is currently wrong. It works, but is slightly faster than 1 second on a 16 MHz CPU

; https://ww1.microchip.com/downloads/en/DeviceDoc/40001917A.pdf
; https://ww1.microchip.com/downloads/aemDocuments/documents/MCU08/ProductDocuments/ReferenceManuals/AVR-InstructionSet-Manual-DS40002198.pdf
; https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/ATmega640-1280-1281-2560-2561-Datasheet-DS40002211A.pdf
; https://github.com/Ro5bert/avra/tree/master

; Tells avra to assemble for processor 2560
; The Atmega2560 memory map (Harvard Architecture):
;   * from address 0x000000 to 0x03FFFF (4,194,304 bytes or 256*16*1024) for the Flash memory
;   * from address 0x0200 to 0x21FF (8,192 bytes or 8*1024) for the Internal SRAM
;   * from address 0x2200 to 0xFFFF (56,832 bytes or (64*1024)-(8*1024)-512) for the External SRAM
;   * from address 0x0000 to 0x0FFF (4,096 bytes or 4*1024) for the EEPROM
.device Atmega2560

; Program starts at 0x000000 on the address bus and it's at 0x000000 on the ROM (goes up to 0x03E800 for the Atmega2560)
.org 0x000000

.def    rTemp = r16
.def    rCounterInner = r17
.def    rCounterMiddle = r18
.def    rCounterOuter = r19

.equ    F_CPU = 16000000  ; Cycles per second (doesn't actually change the oscillator clock rate)
.equ    PINB = 0x03  ; Input - Port B Input Pins Address
.equ    DDRB = 0x04  ; Direction - Port B Data Direction Register (bit value 1 means output, bit value 0 means input)
.equ    PORTB = 0x05  ; Output - Port B Data Register

setup:
    ldi rTemp,0b10000000  ; load's pin directions into temp register (pins 7-0, left to right) - 1 cycle
    out DDRB,rTemp  ; Writes temp register contents to DDR E - 1 cycle (`in` is also 1 cycle)

start:
    ldi rTemp, 0b00000000  ; 1 cycle
    out PORTB,rTemp  ; Writes temp register contents to Port B - 1 cycle

    rcall delay  ; 2 to 4 cycles (dependent on hardware)

    ldi rTemp, 0b10000000  ; 1 cycle
    out PORTB,rTemp  ; 1 cycle

    rcall delay  ; 2 to 4 cycles (dependent on hardware)

    jmp start  ; 3 cycles

delay:
    ; F_CPU (16 MHz or 16,000,000) / Number of cycles per loop (16 right now) / inner loop counter (255) / middle loop counter (255) = outer loop counter (15.378~)
    ldi rCounterInner, 255  ; 1 cycle
    ldi rCounterMiddle, 255  ; 1 cycle
    ldi rCounterOuter, 32  ; 1 cycle

delay_loop:
    ; Decrement Counter by 1
    dec rCounterInner  ; 1 cycle

    nop  ; 1 cycle
    nop  ; 1 cycle
    nop  ; 1 cycle

    ; Inner counter
    ; If counter not 0, jump back to start of loop
    cpi rCounterInner, 0  ; 1 cycle
    brne delay_loop  ; If false, takes 1 cycle, if true, takes 2 cycles

    ; Middle Counter
    dec rCounterMiddle  ; 1 cycle
    cpi rCounterMiddle, 0  ; 1 cycle
    brne delay_loop  ; If false, takes 1 cycle, if true, takes 2 cycles    

    ; Outer Counter
    dec rCounterOuter  ; 1 cycle
    cpi rCounterOuter, 0  ; 1 cycle
    brne delay_loop  ; If false, takes 1 cycle, if true, takes 2 cycles   

    ret  ; 4 to 6 cycles (dependent on hardware)
