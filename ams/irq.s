IRQ:
  pha
  phx
  phy
  php
IRQ_1:
  bbs7 IFR0, VIA0
  bbs7 IFR1, VIA1
  php
  phy
  phx
  pha
  rti

VIA0:
  
  
nmi:
  rti
