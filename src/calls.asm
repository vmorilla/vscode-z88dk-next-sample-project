SECTION code_user

PUBLIC _normal_16_16_r16, _normal_8_8_r16, _normal_8_16_8_r16, _fast_8_8_r16

_normal_16_16_r16:
    ; Args are passed to the stack in reverse order:
    ; DE gets the value of 'A'
    ; HL gets the value of 'B' 
    pop hl   ; hl = return address
    pop de  ; de  = 'b'
    ex (sp),hl   ; hl = 'a'
    add hl, de
    ret


_normal_8_8_r16:
    ; Args are packed in a single 16 bits register in the stack
    ; L gets the first argument
    ; H gets the second argument
    pop hl   ; hl = return address
    ex (sp),hl   ; h = 'b', l = 'a'
    ld e, h
    ld d, 0
    ld h, d
    add hl, de
    ret


_normal_8_16_8_r16:
    ; Args are packed in order: avoid passing an odd number of arguments of 8 bits in first place
    ; E gets the value of 'A'
    ; D gets the low byte of 'B'
    ; L gets the high byte of 'B'
    ; H gets the low byte of 'C'
    pop hl   ; hl = return address
    pop de  ; de  = 'c'
    ex (sp),hl   ; hl = 'a'
    ld b, l
    ld c, d
    ld l, h
    ld h, 0
    ld d, 0
    add hl, de
    add hl, bc
    ret


_fast_8_8_r16:
    ld d, 0
    ld h, d
    add hl, de
    ret
