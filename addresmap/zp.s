.SEGMENT "ZP"
limit_x = $02		;2 byte
limit_y = $04		;2 byte
limit_z = $06		;2 byte
bed_tmp = $08		;2 byte
ext_tmp = $0A		;2 byte
status = $00		;1 byte ;bit 0,1 display byte num(1,4), bit 2 address(0)/data(1), bit 3 axis home
disp_addr = $0C		;4 byte
disp_data = $10		;4 byte
fat32_lba = $14		;4 byte
zp_ifr = $01		;1 byte
