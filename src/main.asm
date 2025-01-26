SECTION code_user

PUBLIC _main

_main:
    xor a
    ld hl, 0x4000
    ld bc, 6912
    ld d,0
vicloop:
    ld (hl), d
    inc d
    inc hl
    dec bc
    ld a, b
    or c
    jr nz, vicloop
    ret


