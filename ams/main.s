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
  lda #%00010100
  sta ACR0
  lda #%10000111        ;int enable, sr enable, CA1,2 enable (filimnet_0, 1)
  sta IER0
  lda #%00001100
  sta ARC1
  lda #%10000111
  sta IER1
  
  jmp loop
  
loop:
  jmp loop

.SEGMENT RESETVEC
  .word nmi
  .word reset
  .word IRQ
