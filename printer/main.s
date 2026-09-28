;printer
.org $E000
.SETCPU 65C02
.INCLUDE ../addressmap/*.s
.INCLUDE irq.s
.INCLUDE print.s
.SEGMENT CODE
rest:
  sei
  cld
  ldx #$00
  txs
  lda #%11111111
  sta DDRB0						;steper moter 0
  sta DDRA0						;steper moter 1
  sta DDRB1						;steper moter 2
  sta DDRA1						;extruder
  lda 
  

  
loop:
 jmp loop

.org $FFFA
.SEGMENT RESETVEC
  .word nmi
  .word reset
  .word IRQ
