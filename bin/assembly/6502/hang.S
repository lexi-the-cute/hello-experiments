; https://raw.githubusercontent.com/dasm-assembler/dasm/master/docs/dasm.pdf
; http://www.6502.org/users/obelisk/6502/instructions.html
; https://www.westerndesigncenter.com/wdc/documentation/w65c02s.pdf

    ; Tells dasm to assemble for processor 6502
    processor 6502
    
    ; Program starts at 0x8000 on the address bus even though it's at 0x0 on the ROM
    ORG $8000

setup:
    cli  ; Enable IRQ Interrupts

start:
    jmp start

nmi:
    rti
irq:
    rti

interrupts:
    ; Pad out rest of file for the AT28C256 (32k ignoring the *8)
    ; NMI (Non-Maskable Interrupt) Pointer
    ORG $FFFA,0xEA
    .word nmi

    ; When the 6502 reset pin is activated, the cpu will read the address to jump to from here
    .word setup

    ; BRK (Software Break)/IRQ (Interrupt Request) Pointer
    .word irq
