parse_mbr:
  LDY #1
skip_page:
  LDX #0
skip_loop1:
  JSR spi_read
  DEX
  BNE skip_loop1
  DEY
  BPL skip_page

  LDX #190

skip_loop2:
  JSR spi_read
  DEX
  BNE skip_loop2

  LDX #4
skip_status:
  JSR spi_read
  DEX
  BNE skip_status

  JSR spi_read
  CMP #$0B
  BEQ type_ok
  CMP #$0C
  BNE mbr_error
type_ok:
  JSR spi_read
  JSR spi_read
  JSR spi_read

  JSR spi_read
  STA fat32_lba
  JSR spi_read
  STA fat32_lba+1
  JSR spi_read
  STA fat32_lba+2
  JSR spi_read
  STA fat32_lba+3

  LDX #52
skip_table:
  JSR spi_read
  DEX
  BNE skip_table

  JSR spi_read
  CMP #$55
  BNE mbr_error

  JSR spi_read
  CMP #$AA
  BNE mbr_error

  JSR spi_read
  JSR spi_read
  RTS
mbr_error:
  
  RTS
