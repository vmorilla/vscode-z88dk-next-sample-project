	SECTION code_driver
	PUBLIC banked_call
	EXTERN l_jphl

	defc CLIB_BANKING_STACK_SIZE = 100

banked_call:
    di
    pop hl
    ld (mainsp), sp             ; Save the current stack pointer
    ld sp, (tempsp)             ; Set the stack poin`ter to the temporary stack

    ld a, (cur_bank)            ; Get the current bank
    ld c, a
    ld e, (hl)                  ; Fetch the call address in de
    inc hl
    ld d, (hl)
    inc hl
    
    ld a, d
    and $c0
    rlc a
    rlc a
    rlc a
    or $50
    ld b, a
    push bc
                         ; Save the current bank in the stack

    ld c, (hl)                  ; ...and page
    inc hl
    inc hl
    push hl                     ; Push the real return address

    call setbank

    ld (tempsp), sp
    ld sp, (mainsp)
    
    ei
    
    ex de, hl                  ; Puts the call address in hl
    call l_jphl

    di
    ld      (mainsp), sp       ; Sets the temporal stack pointer
    ld      sp, (tempsp)

    ; Avoid using de...
    pop de                          ; Get the return address
    pop bc                          ; Pop the old page

    call setbank

    ld      (tempsp), sp       ; Restores the default stack pointer
    ld      sp, (mainsp)

    push de                     ; Push the return address

    ei
    ret

; B: MMU register
; C: Bank number
setbank:
    ld a, b
    ld (setbank_reg1 + 2), a

    inc a

    ld (setbank_reg2 + 2), a
    ld a, c
    ld (cur_bank), a
setbank_reg1:
    nextreg 0, a
    cp $ff
    jr z, setbank_reg2
    inc a
setbank_reg2:
    nextreg 0, a
    ret


    SECTION data_crt

tempsp:     defw  tempstack_end 
cur_bank:   defb $FF

    SECTION bss_crt
mainsp:     defs    2
tempstack:  defs    CLIB_BANKING_STACK_SIZE
tempstack_end: