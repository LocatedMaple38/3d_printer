.SETCPU 65C02
.INCLUDE ../addressmap/*.s
.INCLUDE irq.s
.SEGMENT CODE
rest:
  sei
  cld
  ldx #$00
  txs
  lda #%11111111
  sta DDRB0
  lda #$03
  sta DDRA0
  
  
loop:
  jmp loop

.SEGMENT RESETVEC
  .word nmi
  .word reset
  .word IRQ
