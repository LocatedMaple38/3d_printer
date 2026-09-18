.SETCPU 65C02
.INCLUDE addressmapp.s
.INCLUDE irq.s
.SEGMENT CODE
rest:
  sei
  cld
  lda #%11111111
  sta DDRB0
  sta DDRA0
  sta DDRB1
  sta DDRA1
  lda 
  

  
loop:
 jmp loop

.SEGMENT RESETVEC
  .word nmi
  .word reset
  .word IRQ
