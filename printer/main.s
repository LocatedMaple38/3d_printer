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
  STX status
  LDA #%11111111
  STA DDRA0			;steper moter 0, X
  STA DDRB0			;steper moter 1, Y
  STA DDRA1			;steper moter 2, Z
  STA DDRB1			;steper moter 3, E
  STA DDRA2			;spi decoder bit 0 A0, 1 A1, 2 A2, 7 Enable
  LDA #%11011111		;bit 7 int enable, bit 6 T1 enable, bit 2 T2 disable, bit 4/3 CB1/2 enable, bit 2 SR enable, bit 2/1 CA1/2 enable
  STA IER0
  LDA #%01010101		;bit 7/6/5/4/3/2/1/0 CB/A 1/2 pos. act. edge
  STA PCR0
  LDA #%10000111		;bit 7 int enable, bit 6/5 T1/2 disable, bit 4/3 CB1/2 disable, bit 2 SR enable, bit 1/0 CA1/2 enable
  STA IER1
  STA IER2
  LDA #%00000101		;bit 3/2/1/0 CA2/1 pos. act. edge
  STA PCR1
  LDA #%11000000		;bit 7/6 T1 cont. int./sq. wave out, bit 5/4/3/2/1/0 T2/SR/PA/B disable
  STA ACR0
  LDA #%11000100		;bit 7/6 T1 disable, bit 5 T2 time int., bit 4/3/2 SR Shift in under T2, bit 1/0 PA/B Latch disable
  STA ACR1
  LDA #%00011100		;bit 7/6/5 T1/2 disable, bit 4/3/2 SR shift under ext. clock, bit 1/0 PA/B latch disable
  STA ACR2
  JSR home_axis
  JMP loop

loop:
 JMP loop

spi_read:
  RTS

spi_write:
  RTS
