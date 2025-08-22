
#pragma output REGISTER_SP = 0xBFF0
#pragma output CRT_APPEND_MMAP = 1

; Segment for banked calls. Defaults to 3 (C000 - FFFF)
#pragma output CRT_BANKING_SEGMENT = 3
