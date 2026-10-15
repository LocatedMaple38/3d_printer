;printer
.setcpu "65C02"

.INCLUDE "../addresmap/via.s"
.INCLUDE "../addresmap/eathernet.s"
.INCLUDE "../addresmap/filiment.s"
.INCLUDE "../addresmap/spi.s"
.INCLUDE "../addresmap/zp.s"
.INCLUDE "irq.s"
.INCLUDE "print.s"
.INCLUDE "sd_card.s"

.SEGMENT "CODE"
rest:
  SEI
  CLD
  LDX #$00
  TXS
  LDA #%11111111
  STA DDRA0						;steper moter 0
  STA DDRB0						;steper moter 1
  STA DDRA1						;steper moter 2
  STA DDRB1						;extruder
  STA DDRA2						;spi decoder bit 0 A0, 1 A1, 2 A2, 7 Enable
  LDA #%01010101					;C A/B 1/2 interups enable active high
  STA PCR0
  LDA #%00000101					;CA 1/2 interups enable active low
  STA PCR1
  STA PCR2
  LDA #%00000100					;T1 disable, T2 Timed int, SR Shift in under T2, latch desable A/B
  STA ARC1
  LDA #%00011100					;T1/2 disable, SR out under CB1
  STA PCR2

  JMP loop

loop:
 JMP loop

spi_read:
  rts

spi_write:
  rts
