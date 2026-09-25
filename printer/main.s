.SETCPU 65C02
.INCLUDE ../addressmapp/*.s
.INCLUDE irq.s
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
  lda $%00000111
  sta DDRA1						;spi decoder
  lda 
  

  
loop:
 jmp loop

.SEGMENT RESETVEC
  .word nmi
  .word reset
  .word IRQ
