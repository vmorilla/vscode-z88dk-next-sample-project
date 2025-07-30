	SECTION code_driver
	PUBLIC banked_call
	EXTERN l_jphl, __REG_MMU6, __REG_MMU7

	defc CLIB_BANKING_STACK_SIZE = 100
	defc ZX_BANK_IOPORT = 0x7ffd

banked_call:
    di
    pop hl
    ld (mainsp), sp             ; Save the current stack pointer
    ld sp, (tempsp)             ; Set the stack poin`ter to the temporary stack

    ld a, (cur_bank)            ; Get the current bank
    push af                     ; Save the current bank in the stack

    ld e, (hl)                  ; Fetch the call address in de
    inc hl
    ld d, (hl)
    inc hl                      
    ld a, (hl)                  ; ...and page
    inc hl
    inc hl                      ; Yes this should be here
    push hl                     ; Push the real return address

    ld (tempsp), sp
    ld sp, (mainsp)

    ; Sets MMU 0 and 1 to the new pages (A and A+1)
    ld (cur_bank), a
    nextreg __REG_MMU6, a
    inc a
    nextreg __REG_MMU7, a
    
    ei
    
;    ex de, hl                  ; Puts the call address in hl
    ld l, e
    ld h, d
    call l_jphl

    di
    ld      (mainsp), sp       ; Sets the temporal stack pointer
    ld      sp, (tempsp)

    pop bc                          ; Get the return address
    pop af                          ; Pop the old page

    ld      (tempsp), sp       ; Restores the default stack pointer
    ld      sp, (mainsp)

    push bc                     ; Push the return address

    ; Restores MMU 6 and 7 pages
    ld (cur_bank), a
    nextreg __REG_MMU6, a
    inc a
    nextreg __REG_MMU7, a

    ei
    ret


    SECTION data_crt

tempsp:     defw  tempstack_end 
cur_bank:   defb 0

    SECTION bss_crt
mainsp:     defs    2
tempstack:  defs    CLIB_BANKING_STACK_SIZE
tempstack_end: