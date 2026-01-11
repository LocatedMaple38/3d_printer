.SETCPU 65C02

.SEGMENT CODE
rest:
  sei
  ldx #$00
  txs
  lda #$05
  sta DDRA2
  lda $%01111111
  sta DDRB0
  sta DDRA0
  sta DDRB1
  sta DDRA1
  lda #$90
  sta T1LL
  lda #$01
  sta T1LH
  lda #$55
  sta PCR0
  lda #$ff
  sta DDRB2

  jsr lcd_init
  jsr startup
  cli
  jsr print_init
  jmp loop

print_init:

  rts

startup:
  jsr startup_massege
  rts

startup_massege:
  ldx #0
startup_massege1:
  lda startup,x
  beq startup_dun
  jsr lcd_print
  inx
  jmp startup_massege1
startup_dun:
  rts

lcd_print:
  jsr lcd_wate   ;wait for lcd to be ready
  sta PORTB2     ;proint a reg to lcd
  lda #E         ;enable
  sta PORTA2     ;enable lcd
  lda #$00       ;clear a reg
  sta PORTA2     ;clear lcd enable
  rts

lcd_init:
  lda #%00000001  ;clear lcd display
  jsr lcd_print   ;print to lcd
  lda #%00000010  ;reset curser top left
  jsr lcd_print   ;print to lcd
  lda #%00000110  ;entry mode set
  jsr lcd_print   ;print to lcd
  lda #%00001111  ;display on
  jsr lcd_print   ;print to lcd
  lda #%00010100  ;cursor or display shift off
  jsr lcd_print   ;print to lcd
  lda #%00111000  ;function set
  jsr lcd_print   ;print to lcd
  rts

lcd_wate:
  pha            ;push a reg
lcd_wait1:
  lda #RW        ;read/write
  sta PORTB2     ;set read/write to high on lcd 
  lda (#RW||#E)  ;read/write and enable
  sta PORTB2     ;set read/write and enable to high on lcd
  ldx PORTA2     ;read from lcd
  lda #RW        ;read/write
  sta PORTB2     ;set read/write to high on lcd and clear enable
  txa
  and #$10000000 ;wait for lcd to be ready
  beq lcd_wait1
  lda #$00       ;clear a reg
  sta PORTA2     ;clear lcd enable
  pla            ;pull a reg
  rts

loop:
 jmp loop

nmi:
  
  rti

irq:
  pha
  phx
  phy
  php
irq_1:
  bbs7 IFR0, VIA0
  bbs7 IFR1, VIA1
  bbs7 IFR2, VIA2
  bbs7 IFR3, VIA3
  php
  phy
  phx
  pha
  rti

VIA0:
  bbs6 IFR0, VIA0T1
  bbs5 IFR0, VIA0T2
  bbs4 IFR0, VIA0CB1
  bbs3 IFR0, VIA0CB2
  bbs2 IFR0, VIA0SR
  bbs1 IFR0, VIA0CA1
  bbs0 IFR0, VIA0CA2
  jmp irq_1

VIA1:
  bbs6 IFR1, VIA1T1
  bbs5 IFR1, VIA1T2
  bbs4 IFR1, VIA1CB1
  bbs3 IFR1, VIA1CB2
  bbs2 IFR1, VIA1SR
  bbs1 IFR1, VIA1CA1
  bbs0 IFR1, VIA1CA2
  jmp irq_1

VIA2:
  bbs6 IFR2, VIA2T1
  bbs5 IFR2, VIA2T2
  bbs4 IFR2, VIA2CB1
  bbs3 IFR2, VIA2CB2
  bbs2 IFR2, VIA2SR
  bbs1 IFR2, VIA2CA1
  bbs0 IFR2, VIA2CA2
  jmp irq_1

VIA3:
  bbs6 IFR3, VIA3T1
  bbs5 IFR3, VIA3T2
  bbs4 IFR3, VIA3CB1
  bbs3 IFR3, VIA3CB2
  bbs2 IFR3, VIA3SR
  bbs1 IFR3, VIA3CA1
  bbs0 IFR3, VIA3CA2
  jmp irq_1

VIA0T1:
  
  jmp VIA0

VIA0T2:
  jmp VIA0

VIA0CB1:
  jmp VIA0

VIA0CB2:
  jmp VIA0

VIA0SR:
  jmp VIA0

VIA0CA1:
  jmp VIA0

VIA0CA2:
  jmp VIA0

VIA1T1:
  jmp VIA1

VIA1T2:
  jmp VIA1

VIA1CB1:
  jmp VIA1

VIA1CB2:
  jmp VIA1

VIA1SR:
  jmp VIA1

VIA1CA1:
  jmp VIA1

VIA1CA2:
  jmp VIA1

VIA2T1:
  jmp VIA2

VIA2T2:
  jmp VIA2

VIA2CB1:
  jmp VIA2

VIA2CB2:
  jmp VIA2

VIA2SR:
  jmp VIA2

VIA2CA1:
  jmp VIA2

VIA2CA2:
  jmp VIA2

VIA3T1:
  jmp VIA3

VIA3T2:
  jmp VIA4

VIA3CB1:
  jmp VIA4

VIA3CB2:
  jmp VIA4

VIA3SR:
  jmp VIA4

VIA3CA1:
  jmp VIA4

VIA3CA2:
  jmp VIA4

.SEGMENT TEXT
startup: .asciiz  "welcome"


.SEGMENT RESETVEC
  .word nmi
  .word reset
  .word irq
