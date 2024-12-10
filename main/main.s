  

  .org $E000
rest:
  ldx #$00
  txs
  

loop:
 jmp loop

nmi:
  rti

irq:
  rti


  .org $FFFA
  .word nmi
  .word reset
  .word irq