.SETCPU 65C02

.SEGMENT CODE
rest:
  sei
  smb0 status
  ldx #$00
  txs
  jsr io_init
  jsr startup
  cli
  jsr print_init
  rmb0 stasus
  jmp loop

io_init:
  jsr via_init
  jsr eath_init
  jsr disp_init
  rts

via_init:
  lda #%11100111      	   ;interups true; T1 true; T2 true; CB1 flase; CB2 flase; SR true; CA1 true; CA2 true
  sta IFR0
  lda #%00000100	   ;T1: Timed interrupt(bits 7, 6) ;T2: Timed interrupt, (bit 5) ;Shift Reg: Shift in under control of T2 (bits 4, 3, 2), ;Latch: Disable (bits 1, 0)
  sta ACR0
  lda #%10000111
  sta IFR1
  lda #%00000111	   ;T1: Timed interrupt(bits 7, 6) ; T2: Timed interrupt, (bit 5) ;Shift Reg: Shift out under control of external clock (bits 4, 3, 2), ;Latch: Disable (bits 1, 0)
  sta ACR1
  rts

disp_init:
  lda #$30
  sta disp_addr
  lda #$20
  sta disp_addr+1
  lda #$AC
  sta disp_addr+2
  lda #1
  sta disp_data
  lda #0
  sta T1LH0
  lda #10
  sta T1LL0
  wai
  

print_init:
  
  rts

startup:
  jsr startup_massege
  rts

clear_mem
  ldx #$03
  txa
clear_mem_1:
  sta $(filiment+x << 8) | verion
  sta $(filiment+x << 8) | verion+1
  dex
  bpl clear_mem_1
  sta limit_x
  sta limit_x+1
  sta limit_y
  sta limit_y+1
  sta limit_z
  sta inmit_z+1
  sta bed_tmp
  sta ext_tmp
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
  sta PORTA0     ;proint a reg to lcd
  lda #E         ;enable
  sta PORTB0     ;enable lcd
  lda #$00       ;clear a reg
  sta PORTB0     ;clear lcd enable
  rts

disp_init:
  lda 
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
skip:
  rts

lcd_wate:
  pha            ;push a reg
lcd_wait1:
  lda #RW        ;read/write
  sta PORTB0     ;set read/write to high on lcd
  lda (#RW||#E)  ;read/write and enable
  sta PORRB0     ;set read/write and enable to high on lcd
  ldx PORTA0     ;read from lcd
  lda #RW        ;read/write
  sta PORTB0     ;set read/write to high on lcd and clear enable
  txa
  and #$10000000 ;wait for lcd to be ready
  beq lcd_wait1
  lda #$00       ;clear a reg
  sta PORTB0     ;clear lcd enable
  pla            ;pull a reg
  rts

loop:
 jmp loop

filiment_save_table:
  verion

.SEGMENT TEXT
startup: .asciiz  "welcome"

.SEGMENT RESETVEC
  .word nmi
  .word reset
  .word IRQ
