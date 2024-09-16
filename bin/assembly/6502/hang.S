; https://raw.githubusercontent.com/dasm-assembler/dasm/master/docs/dasm.pdf
; http://www.6502.org/users/obelisk/6502/instructions.html

    ; Tells dasm to assemble for processor 6502
    processor 6502
    
    ; Program starts at 0x8000 on the address bus even though it's at 0x0 on the ROM
    ORG $8000,0xEA

start:
    jmp start

    ; Pad out program for the AT28C256 (32k ignoring the *8)
    ;times 32768-($-$$) db 0xea

    ; When the 6502 reset pin is activated, the cpu will read the address to jump to from here
    ORG $FFFC,0xEA
    .word $8000

    ; Pad out rest of file for the AT28C256 (32k ignoring the *8)
    ORG $FFFE,0xEA
    .word $EAEA