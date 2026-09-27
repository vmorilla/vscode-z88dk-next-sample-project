#include <im2.h>
#include <intrinsic.h>
#include <string.h>
#include <z80.h>
#include "interrupts.h"

// Banked code is paged into 0x0000-0x3FFF (CLIB_BANKING_SEGMENT = 0), which hides the
// ROM and its IM 1 handler at 0x0038. An interrupt while a banked function runs would
// jump into the banked page. So IM 2 is used, with the vector table and the handler
// outside that segment:
// - 0xFD00-0xFE00: 257 byte vector table filled with 0xFE (any vector -> 0xFEFE)
// - 0xFEFE:        JP isr
#define IM2_TABLE 0xFD00
#define IM2_JP_ADDRESS 0xFEFE

IM2_DEFINE_ISR(isr)
{
    // Nothing to do. The macro saves/restores the registers and ends with ei/reti.
}

void setup_interrupts(void)
{
    intrinsic_di();
    memset((void *)IM2_TABLE, IM2_JP_ADDRESS & 0xFF, 257);
    z80_bpoke(IM2_JP_ADDRESS, 0xC3); // JP nn
    z80_wpoke(IM2_JP_ADDRESS + 1, (unsigned int)isr);
    im2_init((void *)IM2_TABLE); // I = 0xFD, IM 2
    intrinsic_ei();
}
