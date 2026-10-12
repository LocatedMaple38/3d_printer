/* printer.ld - Linker Script for 65C02 3D Printer Controller */

MEMORY
{
    ZP  : org = 0x0000, len = 0x00FF   /* Zero Page Variables ($00-$FF) */
    RAM : org = 0x0100, len = 0x7F00   /* System RAM Stack & Data ($0100-$7FFF) */
    IO  : org = 0x8000, len = 0x0050   /* Memory Mapped VIAs ($8000-$804F) */
    ROM : org = 0xE000, len = 0x7FAA   /* 32KB ROM space ($8050-$FFF9) */
    VEC : org = 0xFFFA, len = 0x0006   /* 65C02 Hardware Vectors ($FFFA-$FFFF) */
}

SECTIONS
{
    /* Map Zero Page variables (from zp.s, filiment.s, etc.) */
    .zp : {
        *(.zp)
        *(zp)
    } > ZP

    /* Executable 3D Printer firmware logic */
    .text : {
        *(CODE)
        *(.text)
        *(.rodata)
    } > ROM

    /* Your custom Interrupt service handlers (from irq.s) */
    .interrupts : {
        *(INT)
        *(.interrupts)
    } > ROM

    /* Mandatory absolute 65C02 hardware vector table (from rom.s) */
    .vectors : {
        *(RESETVEC)
        *(.vectors)
    } > VEC
}

