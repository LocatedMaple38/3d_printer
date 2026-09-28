;ams
.SETCPU 65C02
.INCLUDE ../addressmap/*.s
.INCLUDE irq.s
.SEGMENT CODE
rest:
  sei
  cld
  ldx #$00                  ;load x reg with 0
  txs                       ;and set stack pointer to x
  lda #%11111111            ;set DDRB0 to all out puts
  sta DDRB0
  lda #$04                  ;set DDRA0 bit 0,1,2,3 to output (decode address 0-8 bit (0,1,2), external int trigger(bit 4))
  sta DDRA0
  lda #%00010100            ;set ACR0 Shift reg to shift out undr controle of T2 
  sta ACR0
  lda #%10000111            ;int enable, sr, CA1,2 (filimnet_0,1)
  sta IER0
  lda #%00001100            ;set ACR1 Shift reg to shift in undr control of external clock
  sta ACR1
  lda #%10000111            ;int enable, SR, CA1,2 (filiment_2,3)
  sta IER1
  
  
  jmp loop
  
loop:
  jmp loop

.SEGMENT RESETVEC
  .word nmi
  .word reset
  .word IRQ
