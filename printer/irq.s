.segment INT
nmi:
  rti

IRQ:
  pha
  phx
  phy
  php
IRQ_1:
  bbs7 IFR0, VIA0
  bbs7 IFR1, VIA1
  bbs7 IFR2, VIA2
  bbs7 IFR3, VIA3
  bbs7 IFR4, VIA4
  
  bbs7 INT0RD, (eathernet << 8) | INT0RD
  php
  phy
  phx
  pha
  rti

VIA0:
  bbs6 IFR0, VIA0T1
  bbs5 IFR0, VIA0T2
  bbs2 IFR0, VIA0SR
  bbs1 IFR0, VIA0CA1
  bbs0 IFR0, VIA0CA2
  jmp IRQ_1

VIA1:
  bbs6 IFR1, VIA1T1
  bbs5 IFR1, VIA1T2
  bbs2 IFR1, VIA1SR
  bbs1 IFR1, VIA1CA1
  bbs0 IFR1, VIA1CA2
  jmp IRQ_1

VIA2:
  bbs6 IFR2, VIA2T1
  bbs5 IFR2, VIA2T2
  bbs4 IFR2, VIA2CB1
  bbs3 IFR2, VIA2CB2
  bbs2 IFR2, VIA2SR
  bbs1 IFR2, VIA2CA1
  bbs0 IFR2, VIA2CA2
  jmp IRQ_1

VIA3:
  bbs6 IFR3, VIA3T1
  bbs5 IFR3, VIA3T2
  bbs4 IFR3, VIA3CB1
  bbs3 IFR3, VIA3CB2
  bbs2 IFR3, VIA3SR
  bbs1 IFR3, VIA3CA1
  bbs0 IFR3, VIA3CA2
  jmp IRQ_1

VIA4:
  bbs6 IFR4, VIA4T1
  bbs5 IFR4, VIA4T2
  bbs4 IFR4, VIA4CB1
  bbs3 IFR4, VIA4CB2
  bss2 IFR4, VIA4SR
  bbs1 IFR4, VIA4CA1
  bbs0 IFR4, VIA4CA2

VIA0T1:
  bbs0 stasus, VIA0SR
  jmp VIA0

VIA0T2:
  jmp VIA0

VIA0SR:
  jmp VIA0

VIA0CA1:		   ;x axis limit
  jmp VIA0

VIA0CA2:		   ;y axis limit
  jmp VIA0

VIA1T1:
  jmp VIA1

VIA1T2:
  jmp VIA1

VIA1SR:
  bbs0 stasus, VIA1SR_disp_init
  jmp VIA1

VIA0SR_disp_init:
  lda disp_addr
  sta SR1
  

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
  jmp VIA3

VIA3CB1:
  jmp VIA3

VIA3CB2:
  jmp VIA3

VIA3SR:
  jmp VIA3

VIA3CA1:
  jmp VIA3

VIA3CA2:
  jmp VIA3

VIA4T1:
  jmp VIA4

VIA4T2:
  jmp VIA4

VIA4CB1:
  jmp VIA4

VIA4CB2:
  jmp VIA4

VIA4SR:
  jmp VIA4

VIA4CA1:
  jmp VIA4

VIA4CA2:
  jmp VIA4
